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
    view.index(database.all)
  end

  def show(user)
    SearchManager.new(user, database.all).call
  end

  def new
    add_car_id
    add_car_rules
    add_current_data
    create if params.length == 8
  end

  def edit
    id = target_id
    return error('car_not_found') unless database.find_by('id', id)

    params['id'] = id
    edit_manager
  end

  def create
    database.create(params)
    message('advert.create')
  end

  def update
    database.update(params)
    message('advert.update')
  end

  def destroy
    id = target_id
    return error('car_not_found') unless database.find_by('id', id)

    database.delete(id)
    message('advert.delete')
  end

  private

  def target_id
    question('advert.id')
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
      question("car.edit.#{rule}")
      value = gets.chomp
      unless validator.call(rule, value)
        puts error('invalid_car_rule')
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
      rules << I18n.t("flash.hint.advert_rules.#{rule}.#{el}")
    end
    flash.hint(I18n.t("flash.hint.advert_rules.#{rule}.title"), rules)
  end

  def edit_manager
    view.edit(CAR_RULES)
    edit_input
  end

  def edit_input
    input = gets.chomp
    return update if input == 'save'

    input.to_i.between?(0, CAR_RULES.length - 1) ? edit_rule(input) : edit_manager
  end

  def edit_rule(index)
    rule = CAR_RULES[index.to_i]
    question('advert.edit_rule')
    value = gets.chomp
    save_value(rule, value) if validator.call(rule, value)
    edit_manager
  end

  def database
    @database ||= Car.new('cars')
  end

  def view
    @view ||= Cars.new
  end

  def validator
    @validator ||= CarsValidator.new
  end
end
