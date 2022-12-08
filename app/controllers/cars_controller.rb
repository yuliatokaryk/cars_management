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

  def initialize
    super
    @validator = CarsValidator.new
  end

  def show_all
    database.all
  end

  def new
    add_car_id
    rules_collector
    add_current_data
    create if params.length == 8
  end

  def edit
    puts 'Please, write cars id'
    id = gets.chomp
    return puts 'error' unless database.find_by('id', id)

    params['id'] = id
    rules_collector
    update
  end

  def create
    database.create(params)
  end

  def update
    database.update(params)
  end

  def destroy
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

  def database
    Car.new
  end

  def add_car_id
    params['id'] = Time.now.to_i.to_s
  end

  def add_current_data
    params['date_added'] = Time.now.strftime('%d/%m/%Y')
  end

  def rules_collector
    CAR_RULES.each do |rule|
      rule_message(rule)
      puts "#{I18n.t("cars_params.#{rule}")}:".capitalize.colorize(:blue)
      value = gets.chomp
      unless @validator.call(rule, value)
        puts I18n.t('errors.invalid_car_rule').colorize(:red)
        break
      end
      save_value(rule, value)
    end
  end

  def save_value(rule, value)
    numeric_value = %w[year odometer price]
    value = value.to_i if numeric_value.include? rule
    params[rule] = value
  end

  def rule_message(rule)
    table = Terminal::Table.new title: I18n.t("cars_params.#{rule}").to_s.capitalize.colorize(:yellow) do |t|
      INPUT_RULES[rule].each do |el|
        t << [I18n.t("add_rules.#{rule}.#{el}").colorize(:light_blue)]
      end
    end
    puts table
  end
end
