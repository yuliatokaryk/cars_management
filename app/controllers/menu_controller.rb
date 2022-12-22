# frozen_string_literal: true

# Menu controller
class MenuController < ApplicationController
  MENU_OPTIONS = %i[search_car show_cars help exit].freeze
  GUEST_OPTIONS = %i[sign_up log_in].freeze
  USER_OPTIONS = %i[log_out my_searches].freeze
  ADMIN_OPTIONS = %i[create_ad update_ad delete_ad log_out].freeze

  def admin
    menu.admin(ADMIN_OPTIONS)
  end

  def user(user)
    return menu.user(USER_OPTIONS, MENU_OPTIONS) if user

    menu.user(GUEST_OPTIONS, MENU_OPTIONS)
  end

  private

  def menu
    @menu ||= Menu.new
  end
end
