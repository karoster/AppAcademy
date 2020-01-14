require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.


module Searchable

  def self.where(params) #takes a parameter hash
    #has form "col_name1 = ? AND col_name2 = ? ..."
    where_line = params.keys.map { |col_name| "#{col_name} = ?" }.join(" AND ")

    results = DBConnection.execute(<<-SQL, *params.values)
      SELECT *
      FROM #{self.table_name}
      WHERE
        #{where_line}
    SQL

    #turns array of hashes into array of objects (defined in mix-in class)
    self.parse_all(results)
  end


end



class SQLObject
  #extend Searchable

  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL).first.map(&:to_sym)
      SELECT
        * 
      FROM
        #{self.table_name}
    SQL

  end

  def self.finalize!
    self.columns.each do |col_name|
      define_method(col_name) { self.attributes[col_name] } #defining getters in attributes hash
      define_method(col_name.to_s + '=') { |new_val| self.attributes[col_name] = new_val } #defining setters in attributes hash
    end
  end


  def self.table_name=(table_name)
    @table_name = table_name
  end


  def self.table_name
    @table_name = @table_name || self.name.tableize
  end


  def self.all
    results_hash = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL

    self.parse_all(results_hash)
  end


  def self.parse_all(results)
    results.map { |result| self.new(result) }
  end


  def self.find(id)
    result = DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{self.table_name}.id = ?
      LIMIT 1
    SQL

    result.empty? ? nil : self.new(result.first)
  end


  def initialize(params = {})
    params.each do |attr_name, value|
      raise "unknown attribute '#{attr_name}'" unless self.class.columns.include?(attr_name.to_sym)
      self.send(attr_name.to_s + '=', value)
    end
  end


  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col_name|
      self.send(col_name)
    end

  end

  def insert
    cols = self.class.columns
    col_names = "(" + cols.join(", ") + ")"
    question_marks = "(" + (["?"] * cols.length).join(", ") + ")"

    DBConnection.execute(<<-SQL, *attribute_values)
      INSERT INTO
        #{self.class.table_name} #{col_names}
      VALUES
        #{question_marks}
    SQL

    self.id = DBConnection.last_insert_row_id
  end

  def update
    set_line = self.class.columns.map { |col_name| "#{col_name} = ?" }.join(", ")
    DBConnection.execute(<<-SQL, *attribute_values, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{set_line}
      WHERE
        id = ?
    SQL


  end

  def save
    self.id.nil? ? self.insert : self.update
  end
end





