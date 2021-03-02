# frozen_string_literal: true

module GalleryElementsService
  class Create
    attr_reader :image_album, :upload_files, :attach

    def initialize(image_album, uploaded_files)
      @image_album = image_album
      @upload_files = UploadsService::HandleMultipleUpload.new(uploaded_files).call!
    end

    def call!
      elements_options = { is_private: true }
      album_options = { image_album: image_album, album_manual_upload: true }
      @attach = AttachmentsService::Attach.new(nil, upload_files, elements_options: elements_options, album_options: album_options).call!
      self
    end
  end
end
