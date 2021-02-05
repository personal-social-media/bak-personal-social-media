# frozen_string_literal: true

class LoggedIn
  def self.matches?(request)
    return true unless Rails.env.production?

    profile = Profile.first
    return false if profile.blank?
    request.session[:user_id] == profile.id
  end
end
