# frozen_string_literal: true

# service to collect user inputs
class InputCollector
  attr_accessor :rules, :sort_options

  SEARCH_PARAMETERS = %i[make model year_from year_to price_from price_to].freeze
  SORT_PARAMETERS = %i[option direction].freeze

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
    puts I18n.t(:'general.rules_beginning').colorize(:blue)
    SEARCH_PARAMETERS.each do |search_parameter|
      puts "#{I18n.t(:'general.choose_request')} #{I18n.t(:"cars_params.#{search_parameter}")}:".colorize(:blue)
      rules[search_parameter.to_s] = gets.chomp
    end
  end

  def sort_options_collector
    SORT_PARAMETERS.each do |sort_parameter|
      puts "#{I18n.t(:'general.sort_request')} #{I18n.t(:"sort_params.#{sort_parameter}")}:".colorize(:blue)
      sort_options[sort_parameter.to_s] = gets.chomp
    end
  end
end
