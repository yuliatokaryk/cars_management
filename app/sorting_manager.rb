# frozen_string_literal: true

class SortingManager
  attr_accessor :results, :sort_option

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
    sort_option['option(date_added|price)'] == 'price' ? results.sort_by! { |key| key['price'] } : results.sort_by! { |key| Date.strptime(key['date_added'], '%d/%m/%Y') }
  end

  def sort_direction
    results.reverse! unless sort_option['direction(desc|asc)'] == 'asc'
  end
end
