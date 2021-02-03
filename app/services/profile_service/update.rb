# frozen_string_literal: true

module ProfileService
  class Update
    extend Memoist
    attr_reader :profile_params
    def initialize(profile_params, current_user)
      @profile_params = profile_params
      @current_user = current_user
    end

    def call!
      Profile.transaction do
        current_user.update!(profile_params.slice(:name, :gender, :city_name, :about, :country_code))
        profile_image.image = profile_params[:image]
        profile_image.save!
      end
    end

    memoize def profile_image
      image = profile_params[:image]
      return if image.blank?

      current_user.profile_image || ImageFile.new(is_private: false, image_album: image_album)
    end

    memoize def image_album
      ImageAlbum.find_or_create_by(name: "Profile pictures")
    end
  end
end
