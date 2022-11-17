# frozen_string_literal: true

# service for all cars option
class ShowCars
  attr_reader :cars_db

  def call
    load_db
    show_result
  end

  private

  def load_db
    @cars_db = Database.new('cars')
  end

  def show_result
    OutputManager.new(cars_db.fetch).call
  end
end
