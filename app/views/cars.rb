# frozen_string_literal: true

# service to generate cars views
class Cars
  def index(cars)
    rows = []
    cars.each do |car|
      car.each { |parameter, value| rows << [I18n.t("cars.cars_params.#{parameter}").to_s, value.to_s.colorize(:blue)] }
      rows << :separator if cars.last != car
    end
    table = Terminal::Table.new title: I18n.t('cars.title').to_s.colorize(:green), rows: rows
    table.style = { padding_left: 3, border_x: '=', border_i: 'x' }
    puts table
  end

  def edit(rules)
    view_array = []
    rules.each { |rule| view_array << I18n.t("cars.cars_params.#{rule}") }

    table = Terminal::Table.new title: I18n.t('cars.edit.title').to_s.colorize(:yellow) do |t|
      t << view_array
      t << [*0..rules.length - 1]
    end
    puts table
  end
end
