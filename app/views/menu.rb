# frozen_string_literal: true

# service to generate menu view
class Menu
  def index(options)
    table = Terminal::Table.new title: I18n.t('menu.title').to_s.colorize(:yellow) do |t|
      options.each do |key, value|
        t << [I18n.t("menu.#{key}"), value.to_s.colorize(:blue)]
      end
      t.style = { all_separators: true }
    end
    puts table
  end
end
