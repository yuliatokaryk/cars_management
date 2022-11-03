# frozen_string_literal: true

class InputCollector
  attr_accessor :rules, :sort_options

  PARAMETERS = ['make', 'model', 'year_from', 'year_to', 'price_from', 'price_to']
  SORTING = ['sort option(date_added|price)', 'sort direction(desc|asc)']

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
    PARAMETERS.each do |rule|
      Printer.new.call("Please choose #{rule}:")
      rules[rule] = Receiver.new.call
    end
  end

  def sort_options_collector
    SORTING.each do |sort_option|
      Printer.new.call("Please choose #{sort_option}:")
      sort_options[sort_option] = Receiver.new.call
    end
  end
end
