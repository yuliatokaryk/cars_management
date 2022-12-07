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
    value_checker('year')
    value_checker('price')
    count_total_quantity
  end

  private

  def general_choosing(rule_name)
    return if str_checker(search_rules[rule_name])

    cars_list.keep_if { |car| car[rule_name].casecmp(search_rules[rule_name]).zero? }
  end

  def value_checker(rule_name)
    value_from = search_rules["#{rule_name}_from"]
    value_to = search_rules["#{rule_name}_to"]
    return if str_checker(value_from) && str_checker(value_to)

    range_determining(rule_name, value_from, value_to)
  end

  def range_determining(rule_name, value_from, value_to)
    if !str_checker(value_from) && !str_checker(value_to)
      range_from_to(rule_name, value_from, value_to)
    elsif !str_checker(value_from)
      range_from(rule_name, value_from)
    else
      range_to(rule_name, value_to)
    end
  end

  def range_from_to(rule, start_value, end_value)
    cars_list.keep_if { |car| (start_value.to_i..end_value.to_i).cover?(car[rule]) }
  end

  def range_from(rule, start_value)
    cars_list.keep_if { |car| car[rule] >= start_value.to_i }
  end

  def range_to(rule, end_value)
    cars_list.keep_if { |car| car[rule] <= end_value.to_i }
  end

  def str_checker(user_input)
    user_input.strip.empty?
  end

  def count_total_quantity
    @total_quantity = cars_list.length
  end
end
