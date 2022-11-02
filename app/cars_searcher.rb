class CarsSearcher
  attr_accessor :data, :search_rules, :output
  attr_reader :receiver, :printer

  def initialize(data)
    @data = data
    @search_rules = {}
    @printer = Printer.new
    @receiver = Receiver.new
  end

  def call
    printer.call('Please select search rules.')
    general_choosing('make')
    general_choosing('model')
    range_determining('year_from', 'year_to')
    range_determining('price_from', 'price_to')
    sort_options
    sort_direction
    update_statistics
    show_result
  end

  private

  def general_choosing(rule_name)
    printer.call("Please choose #{rule_name}:")
    option = receiver.call
    search_rules["#{rule_name}"] = option

    return if option.strip.empty?

    data.keep_if { |car| car["#{rule_name}"].downcase == option.downcase }
  end

  def range_determining(rule_from, rule_to)
    printer.call("Please choose #{rule_from}:")
    range_from = receiver.call
    search_rules["#{rule_from}"] = range_from
    printer.call("Please choose #{rule_to}:")
    range_to = receiver.call
    search_rules["#{rule_to}"] = range_to

    return if range_from.strip.empty? && range_to.strip.empty?

    if range_from.strip.empty?
      data.keep_if { |car| car['year'] <= range_to.to_i }
    elsif range_to.strip.empty?
      data.keep_if { |car| car['year'] >= range_from.to_i }
    else
      data.keep_if { |car| (range_from.to_i..range_to.to_i).cover?(car['year']) }
    end
  end

  def sort_options
    printer.call('Please choose sort option (date_added|price):')
    result = receiver.call
    result == 'price' ? data.sort_by! { |key| key['price'] } : data.sort_by! { |key| Date.strptime(key['date_added'], '%d/%m/%Y') }
  end

  def sort_direction
    printer.call('Please choose sort option (desc|asc):')
    result = receiver.call
    data.reverse! unless result == 'asc'
  end

  def update_statistics
    StatisticsManager.new(search_rules, data.length).call
  end

  def show_result
    printer.call("---------------------------------------\nResults:")
    if data.empty?
      printer.call('Sorry, there no results')
    else
      data.each do |car|
        car.each { |key, value| puts "#{key}: #{value}" }
        printer.call('---------------------------------------')
      end
    end
  end
end
