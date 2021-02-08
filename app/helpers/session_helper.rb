# frozen_string_literal: true

module SessionHelper
  def current_user
    return @current_user if defined? @current_user
    user_id = session[:user_id]
    return @current_user = nil if user_id.blank?

    @current_user = Profile.find_by(id: user_id).tap do |user|
      if user.blank?
        session[:user_id] = nil
      end
    end
  end

  def signed_in?
    current_user.present?
  end

  def require_current_user
    head 403 unless signed_in?
  end
end
