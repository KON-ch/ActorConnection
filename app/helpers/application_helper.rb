module ApplicationHelper
  def resource_is_user?
    request.fullpath == '/login'
  end

  def review_present?(user, post)
    Review.check_user_review(user, post).empty?
  end
end
