require_relative 'db_connection'
require_relative '01_sql_object'

module Searchable
  def where(params)
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
  # Mixin Searchable here...
  extend Searchable
end
