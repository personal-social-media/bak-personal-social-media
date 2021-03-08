# frozen_string_literal: true

module ProfileService
  class Update
    extend Memoist
    attr_reader :uploaded_file, :profile_params, :current_user, :has_changed, :attach
    def initialize(uploaded_file, profile_params, current_user)
      @uploaded_file = uploaded_file
      @profile_params = profile_params
      @current_user = current_user
    end

    def call!
      Profile.transaction do
        update_attributes

        next update_peer_info if uploaded_file.blank? || !File.exist?(uploaded_file.path)

        @has_changed = true
        elements_options = { is_private: false, remove_existing: true }
        album_options = { album_name: "Profile pictures", album_manual_upload: false }

        @attach = AttachmentsService::Attach.new(current_user, [uploaded_file], elements_options: elements_options, album_options: album_options).call!
        create_post!
        update_peer_info
      end
    end

    private
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

        peer_info.save!
      end

      def create_post!
        post = Post.create!(content: "Changed profile picture")
        uploaded_attachment = attach.output_files.first[:attached_file]
        dup = uploaded_attachment.dup
        dup.subject = post
        dup.save!
      end
  end
end
