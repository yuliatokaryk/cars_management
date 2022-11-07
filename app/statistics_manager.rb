# frozen_string_literal: true

class StatisticsManager
  attr_accessor :db_file, :search_list, :rules, :total_quantity, :search_element

  def initialize(db, rules, total_quantity)
    @db_file = db
    @search_list = db_file.fetch
    @rules = rules
    @total_quantity = total_quantity
  end

  def call
    update_statistics
    save_data_in_db
  end

  private

  def update_statistics
    @search_element = search_list.find { |search_request| search_request['params'] == rules }

    return add_new_search_element unless search_element

    search_element['total_quantity'] = total_quantity
    search_element['requests_quantity'] += 1
  end

  def save_data_in_db
    db_file.record(search_list)
  end

  def add_new_search_element
    @search_element = {}
    search_element['params'] = rules
    search_element['requests_quantity'] = 1
    search_element['total_quantity'] = total_quantity

    search_list << search_element
  end
end
