$data = YAML.load_file 'db/cars.yml' 

class StatisticsManager
  attr_accessor :params, :total_quantity, :database_file, :database, :search_element
  attr_reader :printer

  def initialize(params, total_quantity)
    @params = params
    @total_quantity = total_quantity
    @database_file = Database.new('searches')
    @database = database_file.fetch
    @printer = Printer.new
  end

  def call
    update_statistics
    save_data_in_db
    show_statistic
  end

  private

  def update_statistics
    @search_element = database.find { |element| element['params'] == params }
    
    return add_new_search_element unless search_element

    search_element['total_quantity'] = total_quantity
    search_element['requests_quantity'] += 1
  end

  def save_data_in_db
    database_file.record(database)
  end

  def add_new_search_element
    @search_element = {}
    search_element['params'] = params
    search_element['requests_quantity'] = 1
    search_element['total_quantity'] = total_quantity

    database << search_element
  end

  def show_statistic
    printer.call("---------------------------------------\nStatistic:\nTotal Quantity: #{search_element['total_quantity']}\nRequests quantity: #{search_element['requests_quantity']}")
  end
end
