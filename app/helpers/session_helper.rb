# frozen_string_literal: true

module SessionHelper
  def current_user
    return @current_user if defined? @current_user
    profile_recovery_key_digest = session[:profile_recovery_key_digest]
    return @current_user = nil if profile_recovery_key_digest.blank?
    @current_user = Profile.find_by(recovery_key_digest: profile_recovery_key_digest).tap do |user|
      if user.blank?
        session[:profile_recovery_key_digest] = nil
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
