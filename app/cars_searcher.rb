# frozen_string_literal: true

class CarsSearcher
  attr_accessor :cars_list, :search_rules, :total_quantity

  def initialize(db, rules)
    @cars_list = db.fetch
    @search_rules = rules
    @total_quantity = cars_list.length
  end

  def call
    general_choosing('make')
    general_choosing('model')
    range_determining('year_from', 'year_to')
    range_determining('price_from', 'price_to')
  end

  private

  def general_choosing(rule_name)
    return if search_rules[rule_name].strip.empty?

    @cars_list.keep_if { |car| car[rule_name].downcase == search_rules[rule_name].downcase }
  end

  def range_determining(rule_from, rule_to)
    return if search_rules[rule_from].strip.empty? && search_rules[rule_to].strip.empty?

    if search_rules[rule_from].strip.empty?
      @cars_list.keep_if { |car| car['year'] <= search_rules[rule_to].to_i }
    elsif search_rules[rule_to].strip.empty?
      @cars_list.keep_if { |car| car['year'] >= search_rules[rule_from].to_i }
    else
      @cars_list.keep_if { |car| (search_rules[rule_from].to_i..search_rules[rule_to].to_i).cover?(car['year']) }
    end
  end
end
