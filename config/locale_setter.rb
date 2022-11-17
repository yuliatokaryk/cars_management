# frozen_string_literal: true

# service to choose language
class LocaleSetter
  AVAILABLE_LOCALES = %i[en uk pl].freeze

  def call
    I18n.load_path << Dir["#{File.expand_path('config/locales')}/*.yml"]
    I18n.default_locale = :en

    row = [['en'.colorize(:blue), 'uk'.colorize(:blue), 'pl'.colorize(:blue)]]
    table = Terminal::Table.new headings: %w[English Українська Polski], rows: row
    puts table

    language = gets.chomp.to_sym
    I18n.locale = language if I18n.available_locales.include?(language)
  end
end
