# frozen_string_literal: true

# service to validate email rules
class EmailValidator
  def call(email)
    reg = /^\S{5,}@[\w​.]+\w+$/
    email.match?(reg)
  end
end
