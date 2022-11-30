# frozen_string_literal: true

# App main class
class App
  def initialize(user)
    @user = user
  end

  def call
    input_collector.call
    searcher.call
    sorted_result = sorting_manager.call
    statistics_manager.call
    users_shearchs_controller if @user
    OutputManager.new(sorted_result, statistics_manager.search_element).call
  end

  private

  def cars_db
    @cars_db ||= Database.new('cars')
  end

  def statistics_db
    @statistics_db ||= Database.new('searches')
  end

  def input_collector
    @input_collector ||= InputCollector.new
  end

  def searcher
    @searcher ||= CarsSearcher.new(cars_db, input_collector.rules)
  end

  def sorting_manager
    @sorting_manager ||= SortingManager.new(searcher.cars_list, input_collector.sort_options)
  end

  def statistics_manager
    @statistics_manager ||= StatisticsManager.new(statistics_db, input_collector.rules, searcher.total_quantity)
  end

  def users_shearchs_controller
    UsersSearchesController.new({ 'user' => @user, 'search_rules' => [input_collector.rules] }).save
  end
end
