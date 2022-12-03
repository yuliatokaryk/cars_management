# frozen_string_literal: true

# Cars controller
class CarsController < ApplicationController
  attr_accessor :params

  INPUT_RULES = { 'make' => %w[required min_sym max_sym content],
                  'model' => %w[required min_sym max_sym content],
                  'year' => %w[required type max_value min_value],
                  'odometer' => %w[required type min_value],
                  'price' => %w[required type min_value],
                  'description' => %w[required type max_value] }.freeze

  CAR_RULES = %w[make model year odometer price description].freeze

  def create
    params['id'] = Time.now.to_i.to_s
    rules_collector
    params['date_added'] = Time.now.strftime('%d/%m/%Y')
    database.create(params)
  end

  def update
    puts 'Please, write cars id'
    id = gets.chomp
    car = database.find_by('id', id)
    if car
      params['id'] = id
      rules_collector
      database.update(params)
    else
      puts 'error'
    end
  end

  def delete
    puts 'Please, write cars id'
    id = gets.chomp
    car = database.find_by('id', id)
    if car
      database.delete(id)
    else
      puts 'error'
    end
  end

  private

  def rules_collector
    CAR_RULES.each do |rule|
      rule_message(rule)
      puts "please select #{rule}"
      value = gets.chomp
      validator(rule, value) ? params[rule] = value : break
    end
  end

  def database
    Car.new
  end

  def rule_message(rule)
    table = Terminal::Table.new title: rule.to_s.colorize(:yellow) do |t|
      INPUT_RULES[rule].each do |el|
        t << [I18n.t("add_rules.#{rule}.#{el}").colorize(:light_blue)]
      end
    end
    puts table
  end

  def validator(rule, value)
    case rule
    when 'make' then make_validator(value)
    when 'model' then model_validator(value)
    when 'year' then year_validator(value)
    when 'odometer' then odometer_validator(value)
    when 'price' then price_validator(value)
    when 'description' then description_validator(value)
    end
  end

  def make_validator(make)
    reg = /^[a-zA-Z]{3,50}$/
    make.match?(reg)
  end

  def model_validator(model)
    reg = /^[a-zA-Z]{3,50}$/
    model.match?(reg)
  end

  def year_validator(year)
    current_year = Time.new.year
    min_year = 1900
    return true if year.to_i >= min_year && year.to_i <= current_year

    false
  end

  def odometer_validator(odometer)
    return true if odometer.to_i >= 0

    false
  end

  def price_validator(price)
    return true if price.to_i >= 0

    false
  end

  def description_validator(desc)
    return true if desc.is_a?(String) && desc.length <= 5000 || desc == ''

    false
  end
end
