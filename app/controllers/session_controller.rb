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
    return error('invalid_email') unless EmailValidator.new.call(@email)
    return error('exist_email') if UsersController.new.show('email', @email)

    password_rules
    ask_password
    return error('invalid_password') unless PasswordValidator.new.call(@password)

    save_new_user
    greeting
  end

  def log_in
    ask_email
    user = UsersController.new.show('email', @email)
    return error('no_exist_email') unless user

    ask_password
    return error('invalid_password') unless UsersController.new.check_password(user, @password)

    @current_user = user
    greeting
  end

  def log_out
    farewell
    @current_user = nil
  end

  private

  def greeting
    flash.message(["#{I18n.t('user.greeting')}, #{@current_user['email']}!"])
  end

  def farewell
    flash.message(["#{I18n.t('user.farewell')}, #{@current_user['email']}!"])
  end

  def error(error_message)
    flash.error(error_message)
  end

  def ask_email
    flash.question(I18n.t('user.enter_email'))
    @email = gets.chomp
  end

  def email_rules
    rules = []
    EMAIL_RULES.each do |rule|
      rules << I18n.t("email_rules.#{rule}")
    end
    flash.hint(rules)
  end

  def ask_password
    flash.question(I18n.t('user.enter_password'))
    @password = gets.chomp
  end

  def password_rules
    rules = []
    PASSWORD_RULES.each do |rule|
      rules << I18n.t("password_rules.#{rule}")
    end
    flash.hint(rules)
  end

  def save_new_user
    password = BCrypt::Password.create(@password)
    user = UsersController.new({ 'email' => @email, 'password' => password, 'admin' => false })
    user.create
    @current_user = user.params
  end
end
