# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  def all
    @users = database.fetch
  end

  def find_by(param, value)
    all
    @users.find { |user| user[param] == value }
  end

  def update(user)
    all
    @users << user
    database.record(@users)
  end

  private

  def database
    Database.new('users')
  end
end
