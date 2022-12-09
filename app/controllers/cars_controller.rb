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
    add_car_rules
    add_current_data
    create if params.length == 8
  end

  def edit
    id = target_id
    return error_message('errors.car_not_found') unless database.find_by('id', id)

    params['id'] = id
    edit_manager
  end

  def create
    database.create(params)
    success_message('ad_action.ad_create')
  end

  def update
    database.update(params)
    success_message('ad_action.ad_update')
  end

  def destroy
    id = target_id
    return error_message('errors.car_not_found') unless database.find_by('id', id)

    database.delete(id)
    success_message('ad_action.ad_delete')
  end

  private

  def database
    Car.new
  end

  def target_id
    puts I18n.t('admin_actions.ask_id')
    gets.chomp
  end

  def add_car_id
    params['id'] = Time.now.to_i.to_s
  end

  def add_current_data
    params['date_added'] = Time.now.strftime('%d/%m/%Y')
  end

  def add_car_rules
    CAR_RULES.each do |rule|
      rule_message(rule)
      puts "#{I18n.t("cars_params.#{rule}")}:".capitalize.colorize(:blue)
      value = gets.chomp
      unless @validator.call(rule, value)
        puts error_message('errors.invalid_car_rule')
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

  def edit_manager
    table = Terminal::Table.new title: 'please, select rule to edit. When you done type "save"' do |t|
      t << CAR_RULES
      t << [*0..CAR_RULES.length - 1]
    end
    puts table
    edit_input
  end

  def edit_input
    input = gets.chomp
    return update if input == 'save'

    input.to_i.between?(0, CAR_RULES.length - 1) ? edit_rule(input) : edit_manager
  end

  def edit_rule(index)
    rule = CAR_RULES[index.to_i]
    puts "Please, enter new value. #{CAR_RULES[index.to_i]}:"
    value = gets.chomp
    params[rule] = value if @validator.call(rule, value)
    edit_manager
  end
end
