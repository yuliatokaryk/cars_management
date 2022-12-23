# frozen_string_literal: true

# Search manager class
class SearchManager
  def initialize(user, cars)
    @user = user
    @cars = cars
  end

  def call
    input_collector.call
    searcher.call
    sorted_result = sorting_manager.call
    statistics_manager
    users_searches_controller if @user
    Cars.new.index(sorted_result)
    StatisticsController.new.show(input_collector.rules)
  end

  private

  def statistics_db
    @statistics_db ||= Database.new('searches')
  end

  def input_collector
    @input_collector ||= InputCollector.new
  end

  def searcher
    @searcher ||= CarsSearcher.new(@cars, input_collector.rules)
  end

  def sorting_manager
    @sorting_manager ||= SortingManager.new(searcher.cars_list, input_collector.sort_options)
  end

  def statistics_manager
    StatisticsController.new({ 'rules' => input_collector.rules, 'total_quantity' => searcher.total_quantity }).add
  end

  def users_searches_controller
    d = Time.now.strftime('%d/%m/%Y')
    user = @user['email']
    UsersSearchesController.new({ 'user' => user, 'search_rules' => [[{ 'date' => d }, input_collector.rules]] }).save
  end
end
