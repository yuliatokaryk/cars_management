# frozen_string_literal: true

# Users searches controller
class UsersSearchesController < ApplicationController
  attr_accessor :params

  def show
    user_searches = database.find(params['user'])
    user_searches ? view.show(user_searches['search_rules']) : error('error_searches')
  end

  def save
    database.find(params['user']) ? database.update(params) : database.create(params)
  end

  private

  def database
    @database ||= UserSearch.new('users_search')
  end

  def view
    @view ||= UserSearches.new
  end
end
