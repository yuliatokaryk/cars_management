# frozen_string_literal: true

# service to validate password
class PasswordValidator
  PASSWORD_REGEX = /^(?=.*[A-Z])(?=(.*[@$!%*#?&]){2}).{8,20}$/

  def call(password)
    password.match?(PASSWORD_REGEX)
  end
end
