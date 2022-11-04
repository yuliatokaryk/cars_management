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
    puts "---------------------------------------\nResults:"
    return puts 'Sorry, there no results' if results.empty?

    results.each do |car|
      car.each { |key, value| puts "#{key}: #{value}" }
      puts '---------------------------------------'
    end
  end

  def show_statistic
    puts "Statistic:\n"\
         "Total Quantity: #{statistic['total_quantity']}\n"\
         "Requests quantity: #{statistic['requests_quantity']}\n"\
         "---------------------------------------"
  end
end
