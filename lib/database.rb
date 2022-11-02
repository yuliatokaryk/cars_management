class Database
  attr_accessor :database_file

  def initialize(database_name)
    @database_file = "db/#{database_name}.yml"
    return fetch if File.exists?(database_file)
    File.new("db/#{database_file}", 'w+')
  end

  def record(modifyded_data)
    File.open(database_file, 'r+') { |file| file.write(modifyded_data.to_yaml) }
  end

  def fetch
    YAML.load_file(database_file) || []
  end
end
