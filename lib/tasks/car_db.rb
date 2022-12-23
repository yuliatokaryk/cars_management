# frozen_string_literal: true

namespace :db do
  namespace :cars do
    desc 'Recreate cars database'
    task :clear do
      FileUtils.rm_f('db/cars.yml')
      File.new('db/cars.yml', 'w+')
    end

    desc 'Add cars to car database'
    task :seed do
      num = ENV.fetch('num', 1)
      db = Database.new('cars')
      cars = db.fetch
      new_cars = []
      num.to_i.times do
        new_cars << make_car
      end
      db.update(cars + new_cars)
    end
  end
end

def make_car
  { 'id' => FFaker::Vehicle.vin,
    'make' => FFaker::Vehicle.make,
    'model' => FFaker::Vehicle.model,
    'year' => FFaker::Vehicle.year,
    'odometer' => FFaker::Random.rand(1..300_000),
    'price' => FFaker::Random.rand(1000..500_00),
    'description' => FFaker::Lorem.phrase,
    'date_added' => FFaker::Time.date }
end
