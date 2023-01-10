# frozen_string_literal: true

# Application controller
class ApplicationController
  def initialize(params = {})
    @params = params
  end

  def error(error_message)
    flash.error([I18n.t("flash.error.#{error_message}")])
  end

  def message(flash_message)
    flash.message([I18n.t("flash.message.#{flash_message}")])
  end

  def question(question_message)
    flash.question(I18n.t("flash.question.#{question_message}"))
  end

  def flash
    @flash ||= Flash.new
  end
end
