# frozen_string_literal: true

# User Search Model
class UserSearchs < ApplicationRecord
  def all
    @users_searchs = database.fetch
  end

  def find_by(param)
    all
    @users_searchs.find { |user| user['user'] == param }
  end

  def create(params)
    all
    @users_searchs << params
    database.record(@users_searchs)
  end

  # def update(search_rules)
  #   all
  #   @users_searchs << search_rules
  #   database.record(@users_searchs)
  # end

  private

  def database
    Database.new('users_search')
  end
end
