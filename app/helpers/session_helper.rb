# frozen_string_literal: true

module SessionHelper
  extend Memoist

  memoize def current_user
    user_id = session[:user_id]
    return nil if user_id.blank?

    Profile.find_by(id: user_id).tap do |user|
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
