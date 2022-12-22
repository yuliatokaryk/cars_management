# frozen_string_literal: true

# User Search Model
class UserSearch < ApplicationRecord
  def find(user_email)
    all.find { |user| user['user'] == user_email }
  end

  def create(params)
    users_searchs = all
    users_searchs << params
    update_db(users_searchs)
  end

  def update(params) # rubocop:disable Metrics/AbcSize
    users_searchs = all
    current_user_result = users_searchs.find { |user| user['user'] == params['user'] }
    current_user_result['search_rules'].each do |search|
      if search[0] == params['search_rules'][0][0]
        search << params['search_rules'][0][1]
        return update_db(users_searchs)
      end
    end
    current_user_result['search_rules'] << params['search_rules'][0]
    update_db(users_searchs)
  end
end
