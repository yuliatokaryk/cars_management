# frozen_string_literal: true

# User Search Model
class UserSearch < ApplicationRecord
  def find(user_email)
    all.find { |user| user['user'] == user_email }
  end

  def create(params)
    users_searches = all
    users_searches << params
    update_db(users_searches)
  end

  def update(params) # rubocop:disable Metrics/AbcSize
    users_searches = all
    current_user_result = users_searches.find { |user| user['user'] == params['user'] }
    current_user_result['search_rules'].each do |search|
      if search[0] == params['search_rules'][0][0]
        search << params['search_rules'][0][1]
        return update_db(users_searches)
      end
    end
    current_user_result['search_rules'] << params['search_rules'][0]
    update_db(users_searches)
  end
end
