# frozen_string_literal: true

# service to generate statistics show view
class Statistics
  def show(statistic)
    rows = []
    rows << ["#{I18n.t(:'result_output.total_quantity')}:", statistic['total_quantity'].to_s]
    rows << :separator
    rows << ["#{I18n.t(:'result_output.requests_quantity')}:", statistic['requests_quantity'].to_s]
    table = Terminal::Table.new title: I18n.t(:'result_output.statistic_title').to_s.colorize(:green), rows: rows
    puts table
  end
end
