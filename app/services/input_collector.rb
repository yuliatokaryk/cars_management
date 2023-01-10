# frozen_string_literal: true

# service to collect user inputs
class InputCollector
  attr_accessor :rules, :sort_options

  SEARCH_PARAMETERS = %i[make model year_from year_to price_from price_to].freeze
  SORT_PARAMETERS = %i[option direction].freeze
  FAST_SEARCH_RULES = %i[hint1 hint2 hint3 hint4 hint5].freeze

  def initialize
    @rules = { 'make' => '', 'model' => '', 'year_from' => '', 'year_to' => '', 'price_from' => '', 'price_to' => '' }
    @sort_options = {}
  end

  def call
    rules_collector
    sort_options_collector
  end

  def fast_value
    rule_message
    rule_string = gets.chomp
    fast_hash = string_converter(rule_string)
    return false unless fast_hash.instance_of? Hash

    @rules.each_key { |rule| @rules[rule] = fast_hash[rule] if fast_hash.key?(rule) }
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

  def rule_message
    rules_array = []
    FAST_SEARCH_RULES.each do |rule|
      rules_array << I18n.t("flash.hint.fast_search.#{rule}")
    end
    flash.hint(I18n.t('flash.hint.fast_search.title'), rules_array)
  end

  def string_converter(rules_string)
    rules_hash = {}
    begin
      rules_string.tr(' ', '').split(',').each do |rule|
        rules_hash.merge!(Hash[*rule.split(/[:=]/)])
      end
      rules_hash
    rescue => e # rubocop:disable Style
      error_message(e.to_s.capitalize)
    end
  end

  def error_message(error)
    flash.error([error])
  end

  def flash
    @flash ||= Flash.new
  end
end
