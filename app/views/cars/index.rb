# frozen_string_literal: true

# service to generate cars index view
class CarsIndex
  def initialize(cars)
    @cars = cars
  end

  def call
    rows = []
    @cars.each do |car|
      car.each { |parameter, value| rows << [I18n.t(:"cars_params.#{parameter}").to_s, value.to_s.colorize(:blue)] }
      rows << :separator if @cars.last != car
    end
    table = Terminal::Table.new rows: rows
    table.style = { padding_left: 3, border_x: '=', border_i: 'x' }
    puts table
  end
end
