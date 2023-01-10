# frozen_string_literal: true

# Statistic Model
class Statistic < ApplicationRecord
  def find(rules)
    all.find { |search_request| search_request['params'] == rules }
  end

  def create(element)
    statistics = all
    statistics << element
    update_db(statistics)
  end
end
