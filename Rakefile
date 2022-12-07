# frozen_string_literal: true

require 'faker'
require_relative 'lib/database'

namespace :cars_db do
  desc 'Recreate cars database'
  task :clear_db do
    FileUtils.rm_f('db/cars.yml')
    File.new('db/cars.yml', 'w+')
  end

  desc 'Add a car to cars database'
  task :add_car do
    db = Database.new('cars')
    cars = db.fetch
    cars << make_car
    db.record(cars)
  end

  desc 'Add several cars to car database'
  task :add_cars do
    num = ENV.fetch('num')
    db = Database.new('cars')
    cars = db.fetch
    new_cars = []
    num.to_i.times do
      new_cars << make_car
    end
    db.record(cars + new_cars)
  end
end

def make_car
  { 'id' => Faker::Base.numerify('#####-#####-######-#####'),
    'make' => Faker::Vehicle.make,
    'model' => Faker::Vehicle.model,
    'year' => Faker::Vehicle.year,
    'odometer' => Faker::Vehicle.kilometrage,
    'price' => Faker::Commerce.price(range: 1000..500_00),
    'description' => Faker::Vehicle.car_options.join(', '),
    'date_added' => Faker::Date.between(from: '2020/01/01', to: '2022/12/6') }
end
