# frozen_string_literal: true

# service of main menu
class MainMenu
  MENU_OPTIONS = %i[search_car show_cars help exit].freeze
  NO_USER = %i[sign_up log_in].freeze
  USER = %i[log_out my_searches].freeze
  ADMIN_MENU = %i[create_ad update_ad delete_ad log_out].freeze

  def initialize
    welcome_message
    @session = SessionController.new
  end

  def call
    if @session.current_user && @session.current_user['admin'] == true
      show_admin_menu
      menu_request
      admin_menu_response
    else
      form_user_menu
      show_menu_option
      menu_request
      menu_response
    end
  end

  private

  def welcome_message
    row = [[I18n.t('menu.welcome_message').colorize(:green)]]
    puts Terminal::Table.new rows: row
  end

  def form_user_menu
    @user_option = []
    if !@session.current_user
      NO_USER.each_with_index do |option, index|
        @user_option << [I18n.t("session_menu.#{option}"), index.to_s.colorize(:blue)]
      end
    else
      USER.each_with_index do |option, index|
        @user_option << [I18n.t("session_menu.#{option}"), index.to_s.colorize(:blue)]
      end
    end
  end

  def show_admin_menu
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      ADMIN_MENU.each_with_index do |option, index|
        t << [I18n.t("adnin_menu_options.#{option}"), index.to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def show_menu_option
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      @user_option.each { |option| t << option }
      MENU_OPTIONS.each_with_index do |option, index|
        t << [I18n.t("menu_options.#{option}"), (index + 2).to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def menu_request
    @user_choise = gets.chomp
  end

  def admin_menu_response
    case @user_choise
    when '0' then CarsController.new.create
    when '1' then CarsController.new.update
    when '2' then CarsController.new.delete
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
end

def sesion_option
  @session.current_user ? user_menu : no_user_menu
end

def user_menu
  case @user_choise
  when '0' then @session.log_out
  when '1' then UsersSearchesController.new({ 'user' => @session.current_user }).show
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
  when '3' then ShowCars.new.call
  when '4' then puts I18n.t('menu.help').colorize(:light_blue)
  when '5' then return puts I18n.t('menu.end').colorize(:green)
  end
  call
end
