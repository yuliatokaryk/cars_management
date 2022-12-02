# frozen_string_literal: true

# Cars controller
class CarsController < ApplicationController
  attr_accessor :params

  def create
    params['id'] = Time.now.to_i.to_s
    rules_collector
    params['date_added'] = Time.now.strftime('%d/%m/%Y')
    database.create(params)
  end

  def update
    puts 'Please, write cars id'
    id = gets.chomp
    car = database.find_by('id', id)
    if car
      params['id'] = id
      rules_collector
      database.update(params)
    else
      puts 'error'
    end
  end

  def delete
    puts 'Please, write cars id'
    id = gets.chomp
    car = database.find_by('id', id)
    if car
      database.delete(id)
    else
      puts 'error'
    end
  end

  private

  def rules_collector
    rules = %w[id make model year odometer price description date_added]
    rules[1..-2].each do |rule|
      puts "please select #{rule}"
      params[rule] = gets.chomp
    end
  end

  def database
    Car.new
  end
end
