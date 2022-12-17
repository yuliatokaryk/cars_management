# frozen_string_literal: true

# main app service
class AppService
  def initialize
    set_language
    welcome_message
    @session = SessionController.new
    @menu = MenuController.new
  end

  def call
    if @session.current_user && @session.current_user['admin'] == true
      @menu.admin
      menu_request
      admin_menu_response
    else
      @menu.user(@session.current_user)
      menu_request
      menu_response
    end
  end

  private

  def set_language
    LocaleSetter.new.call
  end

  def welcome_message
    row = [[I18n.t('menu.welcome_message').colorize(:green)]]
    puts Terminal::Table.new rows: row
  end

  def menu_request
    @user_choise = gets.chomp
  end

  def admin_menu_response
    case @user_choise
    when '0' then CarsController.new.new
    when '1' then CarsController.new.edit
    when '2' then CarsController.new.destroy
    when '3' then @session.log_out
    end
    call
  end

  def menu_response
    case @user_choise
    when '0', '1' then sesion_option
    when '2', '3', '4', '5' then cars_option
    else
      call
    end
  end

  def sesion_option
    @session.current_user ? user_menu : no_user_menu
  end

  def user_menu
    case @user_choise
    when '0' then @session.log_out
    when '1' then UsersSearchesController.new({ 'user' => @session.current_user['email'] }).show
    end
    call
  end

  def no_user_menu
    case @user_choise
    when '0' then @session.sign_up
    when '1' then @session.log_in
    end
    call
  end

  def cars_option
    case @user_choise
    when '2' then App.new(@session.current_user).call
    when '3' then CarsController.new.index
    when '4' then puts I18n.t('menu.help').colorize(:light_blue)
    when '5' then return puts I18n.t('menu.end').colorize(:green)
    end
    call
  end
end
