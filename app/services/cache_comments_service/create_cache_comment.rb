# frozen_string_literal: true

module CacheCommentsService
  class CreateCacheComment
    extend Memoist
    attr_reader :params, :comment
    def initialize(params)
      @params = params
    end

    def call!
      CacheComment.transaction do
        @comment = CacheComment.create!(create_params)
        album_title = "Comments"
        uploaded_files_params = params[:uploaded_files]

        if uploaded_files_params.present?
          uploaded_files = UploadsService::HandleMultipleUpload.new(uploaded_files_params).call!
          elements_options = { is_private: false }
          album_options = { album_name: album_title, album_manual_upload: false }
          AttachmentsService::Attach.new(comment, uploaded_files, elements_options: elements_options, album_options: album_options).call!
        else
          comment.sync_create
        end
      end

      comment
    end

    def create_params
      params.except(:uploaded_files)
    end

    memoize def subject
      return nil unless %w(FeedItem).include?(params[:subject_type])
      FeedItem.find_by(id: params[:subject_id])
    end

    memoize def peer_info
      PeerInfo.find_by!(id: params[:peer_info_id])
    end
  end
end
