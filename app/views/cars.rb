# frozen_string_literal: true

# service to generate cars view
class Cars
  def index(cars)
    rows = []
    cars.each do |car|
      car.each { |parameter, value| rows << [I18n.t(:"cars_params.#{parameter}").to_s, value.to_s.colorize(:blue)] }
      rows << :separator if cars.last != car
    end
    table = Terminal::Table.new rows: rows
    table.style = { padding_left: 3, border_x: '=', border_i: 'x' }
    puts table
  end

  def edit(rules)
    table = Terminal::Table.new title: I18n.t('admin_actions.edit_title_hint').to_s.colorize(:yellow) do |t|
      t << rules
      t << [*0..rules.length - 1]
    end
    puts table
  end
end
