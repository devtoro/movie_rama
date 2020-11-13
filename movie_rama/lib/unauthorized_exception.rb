# frozen_string_literal: true

# Custom exception for unauthorized actions
class UnauthorizedException < StandardError
  def message
    "You are not allowed to perform this action"
  end
end
