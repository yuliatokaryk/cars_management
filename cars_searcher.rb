# frozen_string_literal: true

require 'date'
require_relative 'statistics_manager'

class CarsSearcher
  attr_accessor :data, :search_rules

  def initialize(data)
    @data = data
    @search_rules = {}
  end

  def call
    puts 'Please select search rules.'
    choose_make
    choose_model
    choose_year
    choose_price
    sort_options
    sort_direction
    update_statistics
    show_result
  end

  private

  def choose_make
    puts 'Please choose make:'
    make = gets.chomp
    search_rules["make"] = make

    if make.strip.empty?
      return
    end

    data.keep_if { |car| car['make'].downcase == make.downcase }
  end

  def choose_model
    puts 'Please choose model:'
    model = gets.chomp
    search_rules["model"] = model

    if model.strip.empty?
      return
    end

    data.keep_if { |car| car['model'].downcase == model.downcase }
  end

  def choose_year
    puts 'Please choose year_from:'
    year_from = gets.chomp
    search_rules["year_from"] = year_from
    puts 'Please choose year_to:'
    year_to = gets.chomp
    search_rules["year_to"] = year_to

    if year_from.strip.empty? && year_to.strip.empty?
      return
    end

    if year_from.strip.empty?
      data.keep_if { |car| car['year'] <= year_to.to_i }
    elsif year_to.strip.empty?
      data.keep_if { |car| car['year'] >= year_from.to_i }
    else
      data.keep_if { |car| (year_from.to_i..year_to.to_i).cover?(car['year']) }
    end
  end

  def choose_price
    puts 'Please choose price_from:'
    price_from = gets.chomp
    search_rules["price_from"] = price_from
    puts 'Please choose price_to:'
    price_to = gets.chomp
    search_rules["price_to"] = price_to

    if price_from.strip.empty? && price_to.strip.empty?
      return
    end

    if price_from.strip.empty?
      data.keep_if { |car| car['price'] <=  price_to.to_i }
    elsif price_to.strip.empty?
      data.keep_if { |car| car['price'] >=  price_from.to_i }
    else
      data.keep_if { |car| (price_from.to_i..price_to.to_i).cover?(car['price']) }
    end
  end

  def sort_options
    puts 'Please choose sort option (date_added|price):'
    result = gets.chomp
    result == 'price' ? data.sort_by! { |key| key['price'] } : data.sort_by! { |key| Date.strptime(key['date_added'], '%d/%m/%Y') }
  end

  def sort_direction
    puts 'Please choose sort option (desc|asc):'
    result = gets.chomp
    data.reverse! unless result == 'asc'
  end

  def update_statistics
    StatisticsManager.new(search_rules, data.length).call
  end

  def show_result
    puts "---------------------------------------\nResults:"
    if data.empty?
      puts 'Sorry, there no results'
    else
      data.each do |car|
        car.each { |key, value| puts "#{key}: #{value}" }
        puts '---------------------------------------'
      end
    end
  end
end
