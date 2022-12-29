# frozen_string_literal: true

# service to validate email
class EmailValidator
  EMAIL_REGEX = /^\S{5,}@[\w​.]+\w+$/

  def call(email)
    email.match?(EMAIL_REGEX)
  end
end
