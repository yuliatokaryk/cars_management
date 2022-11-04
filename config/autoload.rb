# frozen_string_literal: true

require 'yaml'
require 'date'
require 'terminal-table'
require 'colorize'
require 'i18n'
require_relative '../lib/database'
require_relative '../app/statistics_manager'
require_relative '../app/cars_searcher'
require_relative '../app/input_collector'
require_relative '../app/output_manager'
require_relative '../app/sorting_manager'

I18n.load_path << Dir[File.expand_path("config/locales") + "/*.yml"]
I18n.default_locale = :uk
