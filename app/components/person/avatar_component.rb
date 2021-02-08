# frozen_string_literal: true

class Person::AvatarComponent < ViewComponent::Base
  include UploadsHelper
  attr_reader :url, :options, :profile
  def initialize(url: nil, profile: nil, **options)
    @url = url
    @options = options
    @profile = profile
  end

  def real_url
    url || profile_image || image_path("profiles/placeholder.svg")
  end

  private
    def profile_image
      return nil unless profile
      return handle_profile if profile.is_a? Profile
      return handle_peer_info if profile.is_a? PeerInfo
      nil
    end

    def handle_profile
      return nil unless profile&.profile_image

      url_image_for_device(profile.profile_image)
    end

    def handle_peer_info
      return nil if profile&.avatars.blank?

      url_image_for_device_hash(profile.avatars)
    end
end
