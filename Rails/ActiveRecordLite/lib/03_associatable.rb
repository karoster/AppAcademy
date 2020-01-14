require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end



class BelongsToOptions < AssocOptions

  def initialize(name, options = {})
    default = {
      :primary_key => :id,
      :foreign_key => "#{name}_id".to_sym,
      :class_name => name.to_s.camelcase 
    }

    default.keys.each do |col_name|
      self.send("#{col_name}=", options[col_name] || default[col_name])
    end

  end
end

class HasManyOptions < AssocOptions

  def initialize(name, self_class_name, options = {})
    default = {
      :primary_key => :id,
      :foreign_key => "#{self_class_name.underscore}_id".to_sym,
      :class_name => name.to_s.singularize.camelcase
    }

    default.keys.each do |col_name|
      self.send("#{col_name}=", options[col_name] || default[col_name])
    end

  end
end






module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name, options)


    assoc_options[name] = options

    define_method(name) do 
      options
        .model_class #model class is /not/ self. it is class defined in class_name in call to belongs_to.
        .where(options.primary_key => self.send(options.foreign_key)) #self holds the foreign key, query is happening in options.class_name...
        .first
    end

  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name, self.name, options)


    assoc_options[name] = options

    define_method(name) do
      key_val = self.send(options.primary_key)
      options
        .model_class #model class is /not/ self. it is a class defined in class_name in call to has_many
        .where(options.foreign_key => self.send(options.primary_key)) #options.foreign_key refers to the value (model_class).(options.foreign_key)
        #options.primary_key refers to (self).(options.primary_key).
    end

  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
    @assoc_options ||= {}
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
