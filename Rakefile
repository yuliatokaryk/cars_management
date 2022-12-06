# frozen_string_literal: true

require 'faker'
require_relative 'lib/database'

task :clear_db do
  File.delete('db/cars.yml') if File.exist?('db/cars.yml')
  File.new('db/cars.yml', 'w+')
end

task :add_car do
  car = [{ 'id' => Faker::Base.numerify('#####-#####-######-#####'),
           'make' => Faker::Vehicle.make,
           'model' => Faker::Vehicle.model,
           'year' => Faker::Vehicle.year,
           'odometer' => Faker::Vehicle.kilometrage,
           'price' => Faker::Commerce.price(range: 1000..500_00),
           'description' => Faker::Vehicle.car_options.join(', '),
           'date_added' => Faker::Date.between(from: '2020-01-01', to: '2022-12-6') }]
  Database.new('cars').record(car)
end

task :add_cars do
  num = ENV['num']
  cars = []
  num.to_i.times do
    car = { 'id' => Faker::Base.numerify('#####-#####-######-#####'),
            'make' => Faker::Vehicle.make,
            'model' => Faker::Vehicle.model,
            'year' => Faker::Vehicle.year,
            'odometer' => Faker::Vehicle.kilometrage,
            'price' => Faker::Commerce.price(range: 1000..500_00),
            'description' => Faker::Vehicle.car_options.join(', '),
            'date_added' => Faker::Date.between(from: '2020-01-01', to: '2022-12-6') }
    cars << car
  end
  Database.new('cars').record(cars)
end
