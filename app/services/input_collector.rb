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
    SEARCH_PARAMETERS.each do |search_parameter|
      flash.question(I18n.t("flash.question.car.#{search_parameter}"))
      rules[search_parameter.to_s] = gets.chomp
    end
  end

  def sort_options_collector
    SORT_PARAMETERS.each do |sort_parameter|
      flash.question(I18n.t("flash.question.sort.#{sort_parameter}"))
      sort_options[sort_parameter.to_s] = gets.chomp
    end
  end

  def flash
    @flash ||= Flash.new
  end
end
