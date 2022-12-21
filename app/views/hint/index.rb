# frozen_string_literal: true

# service to generate hint view
class Hint
  def initialize(hints)
    @hints = hints
  end

  def call
    table = Terminal::Table.new do |t|
      @hints.each do |hint|
        t << [hint.colorize(:blue)]
      end
    end
    puts table
  end
end
