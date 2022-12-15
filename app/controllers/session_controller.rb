# frozen_string_literal: true

# Session controller
class SessionController < ApplicationController
  attr_accessor :current_user

  PASSWORD_RULES = %i[rule1 rule2 rule3 rule4].freeze
  EMAIL_RULES = %i[rule1 rule2 rule3].freeze
  @current_user = nil

  def sign_up
    email_rules
    ask_email
    return error_message('invalid_email') unless EmailValidator.new.call(@email)
    return error_message('exist_email') if UsersController.new.show('email', @email)

    password_rules
    ask_password
    return error_message('invalid_password') unless PasswordValidator.new.call(@password)

    save_new_user
    greeting
  end

  def log_in
    ask_email
    user = UsersController.new.show('email', @email)
    return error_message('no_exist_email') unless user

    ask_password
    return error_message('invalid_password') unless UsersController.new.check_password(user, @password)

    @current_user = user
    greeting
  end

  def log_out
    farewell
    @current_user = nil
  end

  private

  def ask_email
    puts I18n.t('user.enter_email').colorize(:blue)
    @email = gets.chomp
  end

  def email_rules
    table = Terminal::Table.new title: I18n.t('email_rules.email_hint').to_s.colorize(:yellow) do |t|
      EMAIL_RULES.each do |rule|
        t << [I18n.t("email_rules.#{rule}").colorize(:light_blue)]
      end
    end
    puts table
  end

  def ask_password
    puts I18n.t('user.enter_password').colorize(:blue)
    @password = gets.chomp
  end

  def password_rules
    table = Terminal::Table.new title: I18n.t('password_rules.password_hint').to_s.colorize(:yellow) do |t|
      PASSWORD_RULES.each do |rule|
        t << [I18n.t("password_rules.#{rule}").colorize(:light_blue)]
      end
    end
    puts table
  end

  def save_new_user
    password = BCrypt::Password.create(@password)
    user = UsersController.new({ 'email' => @email, 'password' => password, 'admin' => false })
    user.create
    @current_user = user.params
  end

  def greeting
    rows = [["#{I18n.t('user.greeting')}, #{@current_user['email']}!".colorize(:green)]]
    puts Terminal::Table.new rows: rows
  end

  def farewell
    rows = [["#{I18n.t('user.farewell')}, #{@current_user['email']}!".colorize(:green)]]
    puts Terminal::Table.new rows: rows
  end

  def error_message(error)
    puts I18n.t("errors.#{error}").colorize(:red)
  end
end
