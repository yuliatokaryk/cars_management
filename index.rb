# frozen_string_literal: true

require_relative 'config/autoload'

cars_db = Database.new('cars')
statistics_db = Database.new('searches')

input_collector = InputCollector.new
input_collector.call

searcher = CarsSearcher.new(cars_db, input_collector.rules)
searcher.call

sorted_result = SortingManager.new(searcher.data, input_collector.sort_options).call

statistics = StatisticsManager.new(statistics_db, input_collector.rules, searcher.total_quantity)
statistics.call

OutputManager.new(sorted_result, statistics.search_element).call
