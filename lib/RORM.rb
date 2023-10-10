require_relative './database_connection'
require_relative './string_operations/case_converter'
require_relative './string_operations/inflector'

module RORM
  def self.included(base)
    base.class_eval do
      base.extend(StaticMethods)
      DatabaseConnection.columns(table).each do |col|
        attr_accessor(col.to_sym)
      end
    end
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      send("#{key}=", value)
    end
  end

  def insert
    values = (1..attributes.count).map { |i| "$#{i}" }
    DatabaseConnection.execute do |conn|
      conn.exec_params("INSERT INTO #{self.class.table} (#{attributes.join(', ')}) VALUES (#{values.join(", ")})", attribute_values)
    end
  end

  def attribute_values
    attributes.map(&method(:public_send))
  end

  def attributes
    self.class.attributes.filter{ |a| send(a) != nil }
  end

  module StaticMethods
    def table
      self.name.snakecase.gsub(/\w+$/) { |s| s.plural }
    end

    def attributes
      DatabaseConnection.columns(table)
    end

    def [](id)
      DatabaseConnection.execute do |con|
        con.exec_params("SELECT * FROM #{table} WHERE id=$1", [id]) do |res|
          return self.new(res[0]) if res.ntuples > 0
        end
      end
    end
  end
end
