# frozen_string_literal: true

# service to generate hint view
class Flash
  def message(messages)
    table = Terminal::Table.new do |t|
      messages.each do |message|
        t << [message.colorize(:green)]
      end
    end
    puts table
  end

  def hint(array)
    table = Terminal::Table.new do |t|
      array.each do |hint|
        t << [hint.colorize(:blue)]
      end
    end
    puts table
  end

  def error(error)
    puts I18n.t("errors.#{error}")
  end

  def question(request)
    puts request.colorize(:blue)
  end
end
