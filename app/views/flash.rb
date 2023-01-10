# frozen_string_literal: true

# service to generate flash views
class Flash
  def message(messages)
    table = Terminal::Table.new do |t|
      messages.each do |message|
        t << [message.colorize(:green)]
      end
    end
    puts table
  end

  def hint(title, array)
    table = Terminal::Table.new title: title.colorize(:yellow) do |t|
      array.each do |hint|
        t << [hint.colorize(:light_blue)]
      end
    end
    puts table
  end

  def error(errors)
    table = Terminal::Table.new do |t|
      errors.each do |error|
        t << [error.colorize(:red)]
      end
    end
    puts table
  end

  def question(request)
    puts "#{request}:".colorize(:blue)
  end

  def help
    options = %w[hint_1 hint_2 hint_3]
    table = Terminal::Table.new do |t|
      options.each do |option|
        t << [I18n.t("flash.help.#{option}").colorize(:light_blue)]
      end
    end
    puts table
  end
end
