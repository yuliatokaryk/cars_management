# frozen_string_literal: true

# Users searches controller
class UsersSearchesController < ApplicationController
  attr_accessor :params

  def show
    user_searches = database.find_by(params['user'])
    user_searches ? show_searchs(user_searches['search_rules']) : show_message
  end

  def save
    user_searches = database.find_by(params['user'])
    user_searches ? database.update(params) : database.create(params)
  end

  private

  def show_searchs(results)
    puts I18n.t('user_searches.searches_title').colorize(:green)
    results.each do |result|
      create_search_table(result)
    end
  end

  def create_search_table(search_result)
    table = Terminal::Table.new title: search_result[0]['date'].colorize(:yellow) do |t|
      search_result[1..].each do |search|
        row = []
        search.each { |key, value| row << "#{key} : #{value}" }
        t << row
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def show_message
    puts I18n.t('user_searches.error_message').colorize(:red)
  end

  def database
    UserSearches.new
  end
end
