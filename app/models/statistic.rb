# frozen_string_literal: true

# Statistic Model
class Statistic < ApplicationRecord
  def find(rules)
    data_list.find { |search_request| search_request['params'] == rules }
  end

  def create(element)
    statistics = data_list
    statistics << element
    update_db(statistics)
  end

  def update(statistics)
    update_db(statistics)
  end
end
