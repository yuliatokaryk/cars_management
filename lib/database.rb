# frozen_string_literal: true

# service to work with database
class Database
  attr_accessor :database_file

  WRITE = 'w'
  WRITE_PLUS = 'w+'
  READ_PLUS = 'r+'

  def initialize(database_name)
    @database_file = "db/#{database_name}.yml"
    database_setup
  end

  def record(modified_data)
    File.open(database_file, READ_PLUS) { |file| file.write(modified_data.to_yaml) }
  end

  def fetch
    YAML.load_file(database_file) || []
  end

  def update(hash)
    File.open(database_file, WRITE) { |file| YAML.dump(hash, file) }
  end

  private

  def database_setup
    return fetch if File.exist?(database_file)

    File.new(database_file.to_s, WRITE_PLUS)
  end
end
