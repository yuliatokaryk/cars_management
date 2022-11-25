# frozen_string_literal: true

# service of main menu
class MainMenu
  MENU_OPTIONS = %i[search_car show_cars help exit].freeze
  NO_USER = %i[log_in sign_up].freeze
  USER = %i[log_out].freeze

  def initialize
    welcome_message
    @session = SessionController.new
  end

  def call
    form_user_menu
    show_menu_option
    menu_request
    menu_response
  end

  private

  def welcome_message
    row = [[I18n.t('menu.welcome_message').colorize(:green)]]
    puts Terminal::Table.new rows: row
  end

  def form_user_menu
    if !@session.current_user
      @user_option = []
      NO_USER.each_with_index do |option, index|
        @user_option << [I18n.t("session_menu.#{option}"), index.to_s.colorize(:blue)]
      end
    else
      @user_option = [[I18n.t('session_menu.log_out'), '1'.to_s.colorize(:blue)]]
    end
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

  def menu_response
    case @user_choise
    when '0', '1'
      sesion_option
    when '2', '3'
      cars_option
    when '4', '5'
      menu_option
    else
      call
    end
  end
end

def sesion_option
  case @user_choise
  when '0'
    @session.log_in
  when '1'
    @session.current_user ? @session.log_out : @session.sign_up
  end
  call
end

def cars_option
  case @user_choise
  when '2'
    App.new.call
  when '3'
    ShowCars.new.call
  end
  call
end

def menu_option
  case @user_choise
  when '4'
    puts I18n.t('menu.help').colorize(:light_blue)
    call
  when '5'
    puts I18n.t('menu.end').colorize(:green)
  end
end
