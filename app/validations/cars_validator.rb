# frozen_string_literal: true

# service to validate cars rules
class CarsValidator
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
    min_year = 1900
    year.to_i.positive? && year.to_i.between?(min_year, current_year)
  end

  def odometer_validator(odometer)
    odometer.to_i.positive?
  end

  def price_validator(price)
    price.to_i.positive?
  end

  def description_validator(desc)
    desc.length <= 5000 || desc == ''
  end
end