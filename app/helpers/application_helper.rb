# frozen_string_literal: true

module ApplicationHelper
  def resource_is_user?
    request.fullpath == '/login'
  end
end
