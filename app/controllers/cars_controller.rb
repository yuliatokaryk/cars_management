# frozen_string_literal: true

# Cars controller
class CarsController < ApplicationController
  attr_accessor :params

  CAR_RULES = %w[make model year odometer price description].freeze

  def index(cars = database.all)
    view.index(cars)
  end

  def show(user, fast)
    cars = SearchManager.new(user, database.all).fast_search if fast

    cars = SearchManager.new(user, database.all).call unless fast

    return error('result_fail') if cars == []

    index(cars) if cars
  end

  def new
    car = CarManager.new.create
    create(car) if car
  end

  def edit
    id = target_id
    car = database.find_by('id', id)
    return error('car_not_found') unless car

    view.index([car])
    view.edit(CAR_RULES)

    edited_car = CarManager.new(car).edit
    update(edited_car)
  end

  def create(car)
    database.create(car)
    message('advert.create')
  end

  def update(car)
    database.update(car)
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

  def view
    @view ||= Cars.new
  end

  def database
    @database ||= Car.new('cars')
  end
end
