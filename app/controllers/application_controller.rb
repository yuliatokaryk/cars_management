# frozen_string_literal: true

# Application controller
class ApplicationController
  def initialize(params = {})
    @params = params
  end

  def error_message(message)
    puts I18n.t(message).colorize(:red)
  end

  def success_message(message)
    puts I18n.t(message).colorize(:green)
  end
end
