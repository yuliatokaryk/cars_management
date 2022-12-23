# frozen_string_literal: true

# main app service
class AppService
  def initialize
    set_language
    welcome_message
  end

  def call
    if session.current_user && @session.current_user['admin'] == true
      menu.admin
      menu_request
      admin_response
    else
      menu.user(session.current_user)
      menu_request
      user_response
    end
  end

  private

  def set_language
    LocaleSetter.new.call
  end

  def welcome_message
    flash.message([I18n.t('flash.message.welcome_message')])
  end

  def farewell_message
    flash.message([I18n.t('flash.message.farewell_message')])
  end

  def hint_message
    flash.help
  end

  def menu_request
    @user_choise = gets.chomp
  end

  def admin_response
    case @user_choise
    when '0' then cars.new
    when '1' then cars.edit
    when '2' then cars.destroy
    when '3' then session.log_out
    end
    call
  end

  def user_response
    case @user_choise
    when '0', '1' then sesion_option
    when '2', '3' then cars_option
    when '4' then hint_message
    when '5' then return farewell_message
    end
    call
  end

  def sesion_option
    session.current_user ? user_menu : guest_menu
  end

  def user_menu
    case @user_choise
    when '0' then session.log_out
    when '1' then UsersSearchesController.new({ 'user' => session.current_user['email'] }).show
    end
  end

  def guest_menu
    case @user_choise
    when '0' then session.sign_up
    when '1' then session.log_in
    end
  end

  def cars_option
    case @user_choise
    when '2' then cars.show(session.current_user)
    when '3' then cars.index
    end
  end

  def session
    @session ||= SessionController.new
  end

  def menu
    @menu ||= MenuController.new
  end

  def cars
    @cars ||= CarsController.new
  end

  def flash
    @flash ||= Flash.new
  end
end
