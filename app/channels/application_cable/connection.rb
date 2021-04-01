# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        profile_recovery_key_digest = request.session[:profile_recovery_key_digest]
        return reject_unauthorized_connection if profile_recovery_key_digest.blank?

        Profile.find_by(recovery_key_digest: profile_recovery_key_digest).tap do |user|
          next if user.present?
          reject_unauthorized_connection
        end
      end
  end
end
