# frozen_string_literal: true

class InputCollector
  attr_accessor :rules, :sort_options

  SEARCH_PARAMETERS = [:make, :model, :year_from, :year_to, :price_from, :price_to]
  SORT_PARAMETERS = [:option, :direction]

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
    puts I18n.t(:rules_beginning).colorize(:blue)
    SEARCH_PARAMETERS.each do |search_parameter|
      puts "#{I18n.t(:choose_request)} #{I18n.t(search_parameter)}:".colorize(:blue)
      rules[search_parameter.to_s] = gets.chomp
    end
  end

  def sort_options_collector
    SORT_PARAMETERS.each do |sort_parameter|
      puts "#{I18n.t(:sort_request)} #{I18n.t(sort_parameter)}:".colorize(:blue)
      sort_options[sort_parameter.to_s] = gets.chomp
    end
  end
end
