# frozen_string_literal: true

# Car Model
class Car < ApplicationRecord
  def all
    cars_list
  end

  def find_by(param, value)
    @cars = cars_list
    @car = @cars.find { |car| car[param] == value }
  end

  def create(car)
    cars = cars_list
    cars << car
    database.update(cars)
  end

  def update(params)
    find_by('id', params['id'])
    params.each do |k, v|
      @car[k] = v unless v.empty? || k == 'date_added'
    end
    database.update(@cars)
  end

  def delete(id)
    find_by('id', id)
    @cars.delete(@car)
    database.update(@cars)
  end

  private

  def database
    Database.new('cars')
  end

  def cars_list
    database.fetch
  end
end
