class CarsSearcher
  attr_accessor :data, :search_rules, :output, :inputer

  def initialize(data)
    @data = data
    @search_rules = {}
    @output = Printer.new
    @inputer = Receiver.new
  end

  def call
    output.print_out('Please select search rules.')
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
    output.print_out("Please choose #{rule_name}:")
    option = inputer.receive_input
    search_rules["#{rule_name}"] = option

    return if option.strip.empty?

    data.keep_if { |car| car["#{rule_name}"].downcase == option.downcase }
  end

  def range_determining(rule_from, rule_to)
    output.print_out("Please choose #{rule_from}:")
    range_from = inputer.receive_input
    search_rules["#{rule_from}"] = range_from
    output.print_out("Please choose #{rule_to}:")
    range_to = inputer.receive_input
    search_rules["#{rule_to}"] = range_to

    if range_from.strip.empty? && range_to.strip.empty?
      return
    end

    if range_from.strip.empty?
      data.keep_if { |car| car['year'] <= range_to.to_i }
    elsif range_to.strip.empty?
      data.keep_if { |car| car['year'] >= range_from.to_i }
    else
      data.keep_if { |car| (range_from.to_i..range_to.to_i).cover?(car['year']) }
    end
  end

  def sort_options
    output.print_out('Please choose sort option (date_added|price):')
    result = inputer.receive_input
    result == 'price' ? data.sort_by! { |key| key['price'] } : data.sort_by! { |key| Date.strptime(key['date_added'], '%d/%m/%Y') }
  end

  def sort_direction
    output.print_out('Please choose sort option (desc|asc):')
    result = inputer.receive_input
    data.reverse! unless result == 'asc'
  end

  def update_statistics
    StatisticsManager.new(search_rules, data.length).call
  end

  def show_result
    output.print_out("---------------------------------------\nResults:")
    if data.empty?
      output.print_out('Sorry, there no results')
    else
      data.each do |car|
        car.each { |key, value| puts "#{key}: #{value}" }
        output.print_out('---------------------------------------')
      end
    end
  end
end
