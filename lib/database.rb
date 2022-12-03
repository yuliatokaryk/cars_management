# frozen_string_literal: true

# service to work with database
class Database
  attr_accessor :database_file

  def initialize(database_name)
    @database_file = "db/#{database_name}.yml"
    database_setup
  end

  # def record(data)
  #   File.open(@file, 'a+') { |file| file.write(data.to_yaml) }
  # end

  def record(modifyded_data)
    File.open(database_file, 'r+') { |file| file.write(modifyded_data.to_yaml) }
  end

  def fetch
    YAML.load_file(database_file) || []
  end

  def remove(hash)
    File.open(database_file, 'w') { |file| YAML.dump(hash, file) }
  end

  private

  def database_setup
    return fetch if File.exist?(database_file)

    File.new(database_file.to_s, 'w+')
  end
end
