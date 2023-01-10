# frozen_string_literal: true

# Search manager class
class SearchManager
  DATE_FORMAT = '%d/%m/%Y'

  def initialize(user, cars)
    @user = user
    @cars = cars
  end

  def fast_search
    return unless input_collector.fast_value

    searcher.call
    statistics_manager
    users_searches_controller if @user
    searcher.cars_list
  end

  def call
    input_collector.call
    searcher.call
    statistics_manager
    users_searches_controller if @user
    sorting_manager.call
  end

  private

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
    d = Time.now.strftime(DATE_FORMAT)
    user = @user['email']
    UsersSearchesController.new({ 'user' => user, 'search_rules' => [[{ 'date' => d }, input_collector.rules]] }).save
  end
end
