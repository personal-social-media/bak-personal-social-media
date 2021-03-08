# frozen_string_literal: true

class Person::AvatarComponent < ViewComponent::Base
  include UploadsHelper
  extend Memoist
  attr_reader :url, :options, :profile, :is_video, :image_size, :video_size, :upload
  def initialize(url: nil, profile: nil, image_size: :original, upload: false, video_size: :short, **options)
    @url = url
    @options = options
    @image_size = image_size
    @profile = profile
    @video_size = video_size
    @upload = upload
  end

  memoize def is_video?
    real_video_url.present?
  end

  def real_image_url
    url || profile_image || placeholder
  end

  memoize def real_video_url
    url || profile_video_url
  end

  def placeholder
    image_path("profiles/placeholder.svg")
  end

  def video_options
    (image_options).tap do |opts|
      opts[:muted] = true
      opts[:loop] = true
      opts[:poster] = video_poster
      opts.merge!(options[:video] || {})
    end
  end

  def image_options
    options.except(:video)
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

      profile.profile_image.image_url(image_size)
    end

    def handle_peer_info
      return nil if profile&.avatars.blank?

      url_for_device_hash(profile.avatars)
    end

    def profile_video_url
      return nil unless profile
      profile.profile_video&.video_url(video_size) if profile.is_a? Profile
      profile.avatars&.dig("original") if profile.is_a? PeerInfo
    end

    def video_poster
      return nil unless profile
      return profile.profile_video&.video_url(:original_screenshot) if profile.is_a?(Profile)
      profile.avatars&.dig("original_screenshot") if profile.is_a? PeerInfo
    end
end
