# frozen_string_literal: true

require_relative 'lib/autoload'

searcher = CarsSearcher.new($data)
searcher.call
