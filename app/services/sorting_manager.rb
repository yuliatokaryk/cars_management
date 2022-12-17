# frozen_string_literal: true

# service to sort search results
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
    if sort_option['option'] == 'price'
      results.sort_by! { |key| key['price'] }
    else
      results.sort_by! { |key| Date.strptime(key['date_added'], DATE_FORMAT) }
    end
  end

  def sort_direction
    results.reverse! unless sort_option['direction'] == DEFAULT_DIRECTION
  end
end
