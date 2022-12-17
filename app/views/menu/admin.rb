# frozen_string_literal: true

# service to generate cars index view
class AdminMenu
  def call(options)
    table = Terminal::Table.new title: I18n.t('menu.hint').to_s.colorize(:yellow) do |t|
      options.each_with_index do |option, index|
        t << [I18n.t("adnin_menu_options.#{option}"), index.to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end
end
