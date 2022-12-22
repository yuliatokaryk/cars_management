# frozen_string_literal: true

# Session controller
class SessionController < ApplicationController
  attr_accessor :current_user

  PASSWORD_RULES = %i[rule1 rule2 rule3 rule4].freeze
  EMAIL_RULES = %i[rule1 rule2 rule3].freeze
  @current_user = nil

  def sign_up
    rules_message('email_rules', EMAIL_RULES)
    ask_email
    return error('invalid_email') unless email_validator.call(@email)
    return error('exist_email') if users.find_by('email', @email)

    rules_message('password_rules', PASSWORD_RULES)
    return error('invalid_password') unless password_validator.call(ask_password)

    save_new_user
    greeting
  end

  def log_in
    user = users.find_by('email', ask_email)

    return error('no_exist_email') unless user

    return error('invalid_password') unless user['password'] == ask_password

    @current_user = user
    greeting
  end

  def log_out
    farewell
    @current_user = nil
  end

  private

  def ask_email
    flash.question(I18n.t('user.enter_email'))
    @email = gets.chomp
  end

  def ask_password
    flash.question(I18n.t('user.enter_password'))
    @password = gets.chomp
  end

  def save_new_user
    password = BCrypt::Password.create(@password)
    user = { 'email' => @email, 'password' => password, 'admin' => false }
    users.create(user)
    @current_user = user
  end

  def rules_message(option, rules)
    rules_array = []
    rules.each do |rule|
      rules_array << I18n.t("flash.hint.#{option}.#{rule}")
    end
    flash.hint(I18n.t("flash.hint.#{option}.title"), rules_array)
  end

  def greeting
    flash.message(["#{I18n.t('user.greeting')}, #{@current_user['email']}!"])
  end

  def farewell
    flash.message(["#{I18n.t('user.farewell')}, #{@current_user['email']}!"])
  end

  def error(error_message)
    flash.error([I18n.t("flash.error.#{error_message}")])
  end

  def users
    @users ||= User.new('users')
  end

  def password_validator
    @password_validator ||= PasswordValidator.new
  end

  def email_validator
    @email_validator ||= EmailValidator.new
  end
end
