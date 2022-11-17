# frozen_string_literal: true

# service of main menu
class MainMenu
  MENU_OPTIONS = %i[search_car show_cars help exit].freeze

  def initialize
    welcome_message
  end

  def call
    show_menu_option
    menu_request
    menu_response
  end

  private

  def welcome_message
    row = [[I18n.t('menu.welcome_message').colorize(:green)]]
    puts Terminal::Table.new rows: row
  end

  def show_menu_option
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      MENU_OPTIONS.each_with_index do |option, index|
        t << [I18n.t("menu_options.#{option}"), (index + 1).to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def menu_request
    @user_choise = gets.chomp
  end

  def menu_response # rubocop:disable Metrics/MethodLength
    case @user_choise
    when '1'
      App.new.call
      call
    when '2'
      ShowCars.new.call
      call
    when '3'
      puts I18n.t('menu.help').colorize(:yellow)
      call
    when '4'
      puts I18n.t('menu.end').colorize(:red)
    else
      call
    end
  end
end
