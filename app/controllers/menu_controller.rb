# frozen_string_literal: true

# Menu controller
class MenuController < ApplicationController
  MENU_OPTIONS = %i[search_car show_cars help exit].freeze
  GUEST_OPTIONS = %i[sign_up log_in].freeze
  USER_OPTIONS = %i[log_out my_searches].freeze
  ADMIN_OPTIONS = %i[create_ad update_ad delete_ad log_out].freeze

  def admin
    AdminMenu.new.call(ADMIN_OPTIONS)
  end

  def user(user)
    if user
      UserMenu.new.call(USER_OPTIONS, MENU_OPTIONS)
    else
      UserMenu.new.call(GUEST_OPTIONS, MENU_OPTIONS)
    end
  end
end
