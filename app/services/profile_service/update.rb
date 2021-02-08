# frozen_string_literal: true

module ProfileService
  class Update
    include UploadsHelper
    extend Memoist
    attr_reader :profile_params, :current_user, :has_changed
    def initialize(profile_params, current_user)
      @profile_params = profile_params
      @current_user = current_user
    end

    def call!
      Profile.transaction do
        update_attributes

        next update_peer_info if profile_image_params.blank?

        @has_changed = true
        profile_image.image = profile_image_params
        profile_image.save!
        current_user.profile_image = profile_image
        update_peer_info
      end
    end

    private
      memoize def profile_image
        ImageFile.new(private: false, image_album: image_album)
      end

      memoize def image_album
        ImageAlbum.find_or_create_by(name: "Profile pictures")
      end

      memoize def profile_image_params
        profile_params[:image]
      end

      def update_attributes
        current_user.assign_attributes(profile_params.slice(:name, :gender, :city_name, :about, :country_code))
        @has_changed = true if current_user.changes.present?
        current_user.save!
      end

      def update_peer_info
        return unless has_changed
        peer_info = current_user.peer_info
        peer_info.assign_attributes(
          about: current_user.about,
          city_name: current_user.city_name,
          country_code: current_user.country_code,
          name: current_user.name
        )
        peer_info.avatars = all_uploaded_image_urls(current_user.profile_image)

        peer_info.save!
      end
  end
end
