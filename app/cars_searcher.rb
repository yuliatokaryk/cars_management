# frozen_string_literal: true

# service to search cars in database
class CarsSearcher
  attr_reader :total_quantity, :search_rules, :cars_list

  def initialize(db, rules)
    @cars_list = db.fetch
    @search_rules = rules
  end

  def call
    general_choosing('make')
    general_choosing('model')
    value_checker('year_from', 'year_to')
    value_checker('price_from', 'price_to')
    count_total_quantity
  end

  private

  def general_choosing(rule_name)
    return if str_checker(search_rules[rule_name])

    cars_list.keep_if { |car| car[rule_name].downcase == search_rules[rule_name].downcase }
  end

  def value_checker(rule_from, rule_to)
    return if str_checker(search_rules[rule_from]) && str_checker(search_rules[rule_to])

    range_determining(rule_from, rule_to)
  end

  def range_determining(start_value, end_value)
    if !str_checker(search_rules[start_value]) && !str_checker(search_rules[end_value])
      range_from_to(start_value, end_value)
    elsif !str_checker(search_rules[start_value])
      range_from(start_value)
    else
      range_to(end_value)
    end
  end

  def range_from_to(start_value, end_value)
    cars_list.keep_if { |car| (search_rules[start_value].to_i..search_rules[end_value].to_i).cover?(car['year']) }
  end

  def range_from(start_value)
    @cars_list.keep_if { |car| car['year'] >= search_rules[start_value].to_i }
  end

  def range_to(end_value)
    @cars_list.keep_if { |car| car['year'] <= search_rules[end_value].to_i }
  end

  def str_checker(user_input)
    user_input.strip.empty?
  end

  def count_total_quantity
    @total_quantity = cars_list.length
  end
end
