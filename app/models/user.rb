# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  def find_by(param, value)
    all.find { |user| user[param] == value }
  end

  def create(user)
    users = all
    users << user
    update_db(users)
  end
end
