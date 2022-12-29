# frozen_string_literal: true

# service to validate cars rules
class CarsValidator
  MAX_DESCRIPTION_LENGTH = 5000
  MIN_YEAR = 1900

  def call(rule, value)
    case rule
    when 'make' then make_validator(value)
    when 'model' then model_validator(value)
    when 'year' then year_validator(value)
    when 'odometer' then odometer_validator(value)
    when 'price' then price_validator(value)
    when 'description' then description_validator(value)
    end
  end

  private

  def make_validator(make)
    reg = /^[a-zA-Z]{3,50}$/
    make.match?(reg)
  end

  def model_validator(model)
    reg = /^[a-zA-Z0-9]{1,50}$/
    model.match?(reg)
  end

  def year_validator(year)
    current_year = Time.new.year
    year.to_i.positive? && year.to_i.between?(MIN_YEAR, current_year)
  end

  def odometer_validator(odometer)
    reg = /^[0-9]*$/
    odometer.match?(reg)
  end

  def price_validator(price)
    price.to_i.positive?
  end

  def description_validator(desc)
    desc.length <= MAX_DESCRIPTION_LENGTH || desc == ''
  end
end
