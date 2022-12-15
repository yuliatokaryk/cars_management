# frozen_string_literal: true

# service to validate password rules
class PasswordValidator
  def call(password)
    reg = /^(?=.*[A-Z])(?=(.*[@$!%*#?&]){2}).{8,20}$/
    password.match?(reg)
  end
end
