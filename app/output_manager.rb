# frozen_string_literal: true

class OutputManager
  attr_accessor :results, :statistic

  def initialize(results, statistic)
    @results = results
    @statistic = statistic
  end

  def call
    show_results
    show_statistic
  end

  private 

  def show_results
    Printer.new.call("---------------------------------------\nResults:")
    return Printer.new.call('Sorry, there no results') if results.empty?

    results.each do |car|
      car.each { |key, value| puts "#{key}: #{value}" }
      Printer.new.call('---------------------------------------')
    end
  end

  def show_statistic
    Printer.new.call("Statistic:\nTotal Quantity: #{statistic['total_quantity']}\nRequests quantity: #{statistic['requests_quantity']}\n---------------------------------------")
  end
end
