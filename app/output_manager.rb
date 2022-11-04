# frozen_string_literal: true

class OutputManager
  attr_accessor :results, :statistic

  def initialize(results, statistic)
    @results = results
    @statistic = statistic
  end

  def call
    show_results
    show_statistic
  end

  private 

  def show_results
    rows = []

    if results.empty?
      rows << ["#{I18n.t(:result_fail)}".colorize(:red)]
    else
      results.each do |car|
        car.each { |parameter, value| rows << ["#{parameter}", "#{value}".colorize(:blue)] }
        rows << :separator if results.last != car 
      end
    end

    table = Terminal::Table.new :title => "#{I18n.t(:result_title)}".colorize(:green), :rows => rows
    puts table
  end

  def show_statistic
    rows = []
    rows << ["#{I18n.t(:total_quantity)}:", "#{statistic['total_quantity']}"]
    rows << :separator
    rows << ["#{I18n.t(:requests_quantity)}:", "#{statistic['requests_quantity']}"]
    table = Terminal::Table.new :title => "#{I18n.t(:statistic_title)}".colorize(:green), :rows => rows
    puts table
  end
end
