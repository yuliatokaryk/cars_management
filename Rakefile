# frozen_string_literal: true

require 'faker'
require_relative 'lib/database'

task :clear_db do
  File.delete('db/cars.yml') if File.exist?('db/cars.yml')
  File.new('db/cars.yml', 'w+')
end

task :add_car do
  db = Database.new('cars')
  cars = db.fetch
  car = { 'id' => Faker::Base.numerify('#####-#####-######-#####'),
          'make' => Faker::Vehicle.make,
          'model' => Faker::Vehicle.model,
          'year' => Faker::Vehicle.year,
          'odometer' => Faker::Vehicle.kilometrage,
          'price' => Faker::Commerce.price(range: 1000..500_00),
          'description' => Faker::Vehicle.car_options.join(', '),
          'date_added' => Faker::Date.between(from: '2020-01-01', to: '2022-12-6') }
  cars << car
  db.record(cars)
end

task :add_cars do
  num = ENV['num']
  db = Database.new('cars')
  cars = db.fetch
  new_cars = []
  num.to_i.times do
    car = { 'id' => Faker::Base.numerify('#####-#####-######-#####'),
            'make' => Faker::Vehicle.make,
            'model' => Faker::Vehicle.model,
            'year' => Faker::Vehicle.year,
            'odometer' => Faker::Vehicle.kilometrage,
            'price' => Faker::Commerce.price(range: 1000..500_00),
            'description' => Faker::Vehicle.car_options.join(', '),
            'date_added' => Faker::Date.between(from: '2020/01/01', to: '2022/12/6') }
    new_cars << car
  end
  db.record(cars + new_cars)
end
