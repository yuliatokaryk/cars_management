# frozen_string_literal: true

# service to create and edit car
class CarManager
  INPUT_RULES = { 'make' => %w[required min_sym max_sym content],
                  'model' => %w[required min_sym max_sym content],
                  'year' => %w[required type max_value min_value],
                  'odometer' => %w[required type min_value],
                  'price' => %w[required type min_value],
                  'description' => %w[required type max_value] }.freeze

  CAR_RULES = %w[make model year odometer price description].freeze

  def initialize(car = {})
    @car = car
  end

  def create
    add_id
    add_rules
    add_current_data
    @car.length == 8 ? @car : nil
  end

  def edit
    flash.question(I18n.t('flash.question.car.edit'))
    input = gets.chomp
    return @car if input == 'save'

    return edit_rule(input.to_i - 1) if input.to_i.between?(1, CAR_RULES.length)

    edit
  end

  private

  def add_id
    @car['id'] = Time.now.to_i.to_s
  end

  def add_rules
    CAR_RULES.each do |rule|
      rule_message(rule)
      flash.question(I18n.t("flash.question.car.create.#{rule}"))
      value = gets.chomp
      unless validator.call(rule, value) == true
        puts error_message(rule, validator.call(rule, value))
        break
      end
      save_value(rule, value)
    end
  end

  def add_current_data
    @car['date_added'] = Time.now.strftime('%d/%m/%Y')
  end

  def edit_rule(index)
    rule = CAR_RULES[index]
    flash.question(I18n.t('flash.question.advert.edit_rule'))
    value = gets.chomp
    save_value(rule, value) if validator.call(rule, value)
    edit
  end

  def save_value(rule, value)
    numeric_value = %w[year odometer price]
    value = value.to_i if numeric_value.include? rule
    @car[rule] = value
  end

  def rule_message(rule)
    rules = []
    INPUT_RULES[rule].each do |el|
      rules << I18n.t("flash.hint.advert_rules.#{rule}.#{el}")
    end
    flash.hint(I18n.t("flash.hint.advert_rules.#{rule}.title"), rules)
  end

  def error_message(rule, errors)
    errors.each_with_index do |error, index|
      errors[index] = I18n.t("flash.error.#{rule}.#{error}")
    end
    flash.error(errors)
  end

  def validator
    @validator ||= CarsValidator.new
  end

  def flash
    @flash ||= Flash.new
  end
end
