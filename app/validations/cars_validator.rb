# frozen_string_literal: true

# service to validate cars rules
class CarsValidator
  MAX_DESCRIPTION_LENGTH = 5000
  MIN_YEAR = 1900
  REGEX_ONLY_NUMBERS = /^[0-9]*$/
  REGEX_ONLY_LETTERS = /^[a-zA-Z]*$/
  REGEX_LETTERS_NUMBERS = /^[a-zA-Z0-9]*$/

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
    errors = []
    errors << 'required' if make.strip == ''
    errors << 'min_sym' if make.length < 3
    errors << 'max_sym' if make.length > 50
    errors << 'content' unless make.match?(REGEX_ONLY_LETTERS)
    return true if errors.length.zero?

    errors
  end

  def model_validator(model)
    errors = []
    errors << 'required' if model.strip == ''
    errors << 'min_sym' if model.length < 2
    errors << 'max_sym' if model.length > 50
    errors << 'content' unless model.match?(REGEX_LETTERS_NUMBERS)
    return true if errors.length.zero?

    errors
  end

  def year_validator(year)
    errors = []
    current_year = Time.new.year
    errors << 'required' if year.strip == ''
    errors << 'type' unless year.match?(REGEX_ONLY_NUMBERS)
    errors << 'max_value' if year.to_i > current_year
    errors << 'min_value' if year.to_i < MIN_YEAR
    return true if errors.length.zero?

    errors
  end

  def odometer_validator(odometer)
    errors = []
    errors << 'required' if odometer.strip == ''
    errors << 'type' unless odometer.match?(REGEX_ONLY_NUMBERS)
    errors << 'min_value' unless odometer.to_i.zero? || odometer.to_i.posivive?
    return true if errors.length.zero?

    errors
  end

  def price_validator(price)
    errors = []
    errors << 'required' if price.strip == ''
    errors << 'type' unless price.match?(REGEX_ONLY_NUMBERS)
    errors << 'min_value' unless price.to_i.positive?
    return true if errors.length.zero?

    errors
  end

  def description_validator(desc)
    return true if desc.strip == ''

    errors = []
    errors << type unless desc.match?(REGEX_ONLY_LETTERS)
    errors << max_value if desc.length > MAX_DESCRIPTION_LENGTH
    return true if errors.length.zero?

    errors
  end
end
