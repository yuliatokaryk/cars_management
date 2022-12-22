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

  def index
    cars.index(database.all)
  end

  def show(user)
    SearchManager.new(user).call
  end

  def new
    add_car_id
    add_car_rules
    add_current_data
    create if params.length == 8
  end

  def edit
    id = target_id
    return flash.error('car_not_found') unless database.find_by('id', id)

    params['id'] = id
    edit_manager
  end

  def create
    database.create(params)
    flash.message(['ad_action.ad_create'])
  end

  def update
    database.update(params)
    flash.message(['ad_action.ad_update'])
  end

  def destroy
    id = target_id
    return flash.error('car_not_found') unless database.find_by('id', id)

    database.delete(id)
    flash.message(['ad_action.ad_delete'])
  end

  private

  def database
    @database ||= Car.new('cars')
  end

  def target_id
    flash.question(I18n.t('admin_actions.ask_id'))
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
      flash.question(I18n.t("cars_params.#{rule}"))
      value = gets.chomp
      unless @validator.call(rule, value)
        puts flash.error('invalid_car_rule')
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
    rules = []
    INPUT_RULES[rule].each do |el|
      rules << I18n.t("add_rules.#{rule}.#{el}")
    end
    flash.hint(rules)
  end

  def edit_manager
    cars.edit(CAR_RULES)
    edit_input
  end

  def edit_input
    input = gets.chomp
    return update if input == 'save'

    input.to_i.between?(0, CAR_RULES.length - 1) ? edit_rule(input) : edit_manager
  end

  def edit_rule(index)
    rule = CAR_RULES[index.to_i]
    flash.question("#{I18n.t('admin_actions.edit_rule')}. #{I18n.t("cars_params.#{rule}")}:")
    value = gets.chomp
    save_value(rule, value) if validator.call(rule, value)
    edit_manager
  end

  def cars
    @cars ||= Cars.new
  end

  def validator
    @validator = CarsValidator.new
  end
end
