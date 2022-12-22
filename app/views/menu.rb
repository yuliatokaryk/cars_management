# frozen_string_literal: true

# service to generate menu views
class Menu
  def admin(options)
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      options.each_with_index do |option, index|
        t << [I18n.t("adnin_menu_options.#{option}"), index.to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end

  def user(user_option, menu_options)
    options = {}
    user_option.each_with_index { |option, index| options[option] = index }
    menu_options.each_with_index { |option, index| options[option] = index + 2 }
    show_menu(options)
  end

  def show_menu(hash)
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      hash.each do |key, value|
        t << [I18n.t("menu_options.#{key}"), value.to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end
end
