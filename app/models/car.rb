# frozen_string_literal: true

# Car Model
class Car < ApplicationRecord
  def find_by(param, value)
    @cars = all
    @car = @cars.find { |car| car[param] == value }
  end

  def create(car)
    cars = all
    cars << car
    update_db(cars)
  end

  def update(params)
    find_by('id', params['id'])
    params.each do |k, v|
      @car[k] = v unless v.to_s.empty?
    end
    update_db(@cars)
  end

  def delete(id)
    find_by('id', id)
    @cars.delete(@car)
    update_db(@cars)
  end
end
