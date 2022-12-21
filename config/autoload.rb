# frozen_string_literal: true

require 'yaml'
require 'date'
require 'terminal-table'
require 'colorize'
require 'i18n'
require 'bcrypt'
require 'rake'
require 'ffaker'
require_relative 'locale_setter'
require_relative '../lib/database'

# controllers
require_relative '../app/controllers/application_controller'
require_relative '../app/controllers/cars_controller'
require_relative '../app/controllers/session_controller'
require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/users_searches_controller'
require_relative '../app/controllers/menu_controller'
require_relative '../app/controllers/statistics_controller'

# models
require_relative '../app/models/application_record'
require_relative '../app/models/car'
require_relative '../app/models/user'
require_relative '../app/models/user_searches'
require_relative '../app/models/statistic'

# validations
require_relative '../app/validations/cars_validator'
require_relative '../app/validations/password_validator'
require_relative '../app/validations/email_validator'

# views
require_relative '../app/views/cars/index'
require_relative '../app/views/menu/admin'
require_relative '../app/views/menu/user'
require_relative '../app/views/statistics/statistics'

# services
require_relative '../app/services/app_service'
require_relative '../app/services/app'
require_relative '../app/services/cars_searcher'
require_relative '../app/services/input_collector'
require_relative '../app/services/output_manager'
require_relative '../app/services/sorting_manager'
