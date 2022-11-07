# frozen_string_literal: true

class InputCollector
  attr_accessor :rules, :sort_options

  SEARCH_PARAMETERS = ['make', 'model', 'year_from', 'year_to', 'price_from', 'price_to']
  SORT_PARAMETERS = ['option(date_added|price)', 'direction(desc|asc)']

  def initialize
    @rules = {}
    @sort_options = {}
  end

  def call
    rules_collector
    sort_options_collector
  end

  private

  def rules_collector
    puts "Please select search rules."
    SEARCH_PARAMETERS.each do |search_parameter|
      puts "Please choose #{search_parameter}:"
      rules[search_parameter] = gets.chomp
    end
  end

  def sort_options_collector
    SORT_PARAMETERS.each do |sort_parameter|
      puts "Please choose sort #{sort_parameter}:"
      sort_options[sort_parameter] = gets.chomp
    end
  end
end
