# frozen_string_literal: true

# Hint controller
class HintController < ApplicationController
  def index
    HintIndex.new.call
  end
end
