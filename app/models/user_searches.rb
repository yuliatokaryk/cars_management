# frozen_string_literal: true

# User Search Model
class UserSearches < ApplicationRecord
  def initialize
    super
    all
  end

  def all
    @users_searchs = database.fetch
  end

  def find_by(param)
    @users_searchs.find { |user| user['user'] == param }
  end

  def create(params)
    @users_searchs << params
    save_db
  end

  def update(params) # rubocop:disable Metrics/AbcSize
    current_user_result = @users_searchs.find { |user| user['user'] == params ['user'] }
    current_user_result['search_rules'].each do |search|
      if search[0] == params['search_rules'][0][0]
        search << params['search_rules'][0][1]
        return save_db
      end
    end
    current_user_result['search_rules'] << params['search_rules'][0]
    save_db
  end

  private

  def save_db
    database.record(@users_searchs)
  end

  def database
    Database.new('users_search')
  end
end
