# frozen_string_literal: true

# service to generate hint index view
class HintIndex
  def call
    puts I18n.t('menu.help').colorize(:light_blue)
  end
end
