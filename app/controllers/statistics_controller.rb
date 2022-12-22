# frozen_string_literal: true

# Statistics controller
class StatisticsController < ApplicationController
  def add
    database.find(@params['rules']) ? edit : new
  end

  def show(rules)
    view.show(database.find(rules))
  end

  private

  def new
    @search_element = {}
    @search_element['params'] = @params['rules']
    @search_element['requests_quantity'] = 1
    @search_element['total_quantity'] = @params['total_quantity']
    create
  end

  def create
    database.create(@search_element)
  end

  def edit
    statistics = database.all
    search_element = statistics.find { |search_request| search_request['params'] == @params['rules'] }
    search_element['total_quantity'] = @params['total_quantity']
    search_element['requests_quantity'] += 1
    database.update(statistics)
  end

  def database
    @database ||= Statistic.new('searches')
  end

  def view
    @view ||= Statistics.new
  end
end
