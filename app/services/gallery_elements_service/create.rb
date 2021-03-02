# frozen_string_literal: true

module GalleryElementsService
  class Create
    attr_reader :image_album, :upload_files, :attach

    def initialize(image_album, uploaded_files)
      @image_album = image_album
      @upload_files = UploadsService::HandleMultipleUpload.new(uploaded_files).call!
    end

    def call!
      @attach = AttachmentsService::Attach.new(nil, upload_files, true, image_album: image_album).call!
      self
    end
  end
end
