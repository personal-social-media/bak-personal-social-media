# frozen_string_literal: true

module ProfileService
  class Update
    extend Memoist
    attr_reader :profile_params, :current_user
    def initialize(profile_params, current_user)
      @profile_params = profile_params
      @current_user = current_user
    end

    def call!
      Profile.transaction do
        current_user.update!(profile_params.slice(:name, :gender, :city_name, :about, :country_code))
        next if profile_image_params.blank?
        profile_image.image = profile_image_params
        profile_image.save!
        current_user.profile_image = profile_image
      end
    end

    private
      memoize def profile_image
        current_user.profile_image || ImageFile.new(private: false, image_album: image_album)
      end

      memoize def image_album
        ImageAlbum.find_or_create_by(name: "Profile pictures")
      end

      memoize def profile_image_params
        profile_params[:image]
      end
  end
end
