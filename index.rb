# frozen_string_literal: true

require 'yaml'
require_relative 'cars_searcher'

data = YAML.load_file 'cars.yml'

searcher = CarsSearcher.new(data)
searcher.call
