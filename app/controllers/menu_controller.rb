# frozen_string_literal: true

# Menu controller
class MenuController < ApplicationController
  MENU_OPTIONS = %i[search_car show_cars fast_search help exit].freeze
  GUEST_OPTIONS = %i[sign_up log_in].freeze
  USER_OPTIONS = %i[log_out my_searches].freeze
  ADMIN_OPTIONS = %i[create_ad update_ad delete_ad log_out].freeze

  def admin
    options = {}
    ADMIN_OPTIONS.each_with_index { |option, index| options[option] = index }
    view.index(options)
  end

  def user(current_user)
    options = {}
    if current_user
      USER_OPTIONS.each_with_index { |option, index| options[option] = index }
    else
      GUEST_OPTIONS.each_with_index { |option, index| options[option] = index }
    end

    MENU_OPTIONS.each_with_index { |option, index| options[option] = index + 2 }

    view.index(options)
  end

  private

  def view
    @view ||= Menu.new
  end
end
