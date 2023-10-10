require 'pg'

class DatabaseConnection
  def self.execute
    connection = PG.connect(dbname: 'localhost')
    begin
      yield(connection)
    ensure
      connection.finish
    end
  end

  def self.table_names
    execute do |connection|
      connection.exec("SELECT * FROM pg_catalog.pg_tables WHERE schemaname != 'pg_catalog' AND schemaname != 'information_schema';") do |res|
        return res.map { |rows| rows.values_at('tablename').first }
      end
    end
  end

  def self.columns(table_name)
    execute do |connection|
      connection.exec_params("SELECT * FROM #{table_name} LIMIT 0") do |res|
        return res.fields
      end
    end
  end
end
