# frozen_string_literal: true

class SortingManager
  attr_accessor :results, :sort_option

  DEFAULT_DIRECTION = 'asc'
  DATE_FORMAT = '%d/%m/%Y'
  
  def initialize(results, sort_option)
    @results = results
    @sort_option = sort_option
  end

  def call
    sort_by_parameter
    sort_direction
    results
  end

  private

  def sort_by_parameter
    sort_option['option(date_added|price)'] == 'price' ? results.sort_by! { |key| key['price'] } : results.sort_by! { |key| Date.strptime(key['date_added'], DATE_FORMAT) }
  end

  def sort_direction
    results.reverse! unless sort_option['direction(desc|asc)'] == DEFAULT_DIRECTION
  end
end
