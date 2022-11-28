# frozen_string_literal: true

# Users controller
class UsersSearchersController < ApplicationController
  attr_accessor :params

  def show
    user_searches = database.find_by(params['user'])
    user_searches ? show_searchs(user_searches) : show_message
  end

  def save
    database.create(params)
  end

  private

  def show_searchs(result)
    table = Terminal::Table.new title: 'Your searches'.colorize(:yellow) do |t|
      result['search_rules'].each do |key, value|
        t << [key, value]
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def show_message
    puts I18n.t('user_searches.error_message').colorize(:red)
  end

  def database
    UserSearchs.new
  end
end
