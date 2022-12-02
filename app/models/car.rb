# frozen_string_literal: true

# Car Model
class Car < ApplicationRecord
  def all
    @cars = database.fetch
  end

  def find_by(param, value)
    all
    @cars.find { |car| car[param] == value }
  end

  def create(car)
    all
    @cars << car
    database.record(@cars)
  end

  def update(params)
    all
    car = @cars.find { |item| item['id'] == params['id'] }
    params.each do |k, v|
      car[k] = v unless v.empty?
    end
    database.record(@cars)
  end

  # def delete(id)
  #   all
  #   car = @cars.find { |item| item['id'] == id }
  #   @cars.delete(car)
  #   database.record(@cars)
  # end

  private

  def database
    Database.new('cars')
  end
end
