# frozen_string_literal: true

# service to output app result in console
class OutputManager
  attr_accessor :results, :statistic

  def initialize(results, statistic)
    @results = results
    @statistic = statistic
  end

  def call
    console_output(show_results)
    console_output(show_statistic)
  end

  private

  def show_results
    rows = []

    if results.empty?
      rows << [I18n.t(:'result_output.result_fail').to_s.colorize(:red)]
    else
      results.each do |car|
        car.each { |parameter, value| rows << [I18n.t(:"cars_params.#{parameter}").to_s, value.to_s.colorize(:blue)] }
        rows << :separator if results.last != car
      end
    end

    Terminal::Table.new title: I18n.t(:'result_output.result_title').to_s.colorize(:green), rows: rows
  end

  def show_statistic
    rows = []
    rows << ["#{I18n.t(:'result_output.total_quantity')}:", statistic['total_quantity'].to_s]
    rows << :separator
    rows << ["#{I18n.t(:'result_output.requests_quantity')}:", statistic['requests_quantity'].to_s]
    Terminal::Table.new title: I18n.t(:'result_output.statistic_title').to_s.colorize(:green), rows: rows
  end

  def console_output(output)
    puts output
  end
end
