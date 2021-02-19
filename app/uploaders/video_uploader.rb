# frozen_string_literal: true

class VideoUploader < Shrine
  include ImageProcessing::Vips
  plugin :add_metadata

  plugin :backgrounding
  # The determine_mime_type plugin allows you to determine and store the actual MIME type of the file analyzed from file content.
  plugin :determine_mime_type
  # The validation_helpers plugin provides helper methods for validating attached files.
  plugin :validation_helpers
  # The pretty_location plugin attempts to generate a nicer folder structure for uploaded files.
  plugin :pretty_location
  # Allows you to define processing performed for a specific action.
  plugin :processing
  # The versions plugin enables your uploader to deal with versions, by allowing you to return a Hash of files when processing.
  plugin :versions
  # The delete_raw plugin will automatically delete raw files that have been uploaded. This is especially useful when doing processing, to ensure that temporary files have been deleted after upload.
  plugin :delete_raw
  plugin :recache

  # Define validations
  # For a complete list of all validation helpers, see AttacherMethods. http://shrinerb.com/rdoc/classes/Shrine/Plugins/ValidationHelpers/AttacherMethods.html
  Attacher.validate do
    validate_max_size 10.gigabytes, message: "is too large (max is 10 GB)"
    validate_mime_type_inclusion %w[video/mp4 video/webm video/ogg]
  end

  # Process additional versions in background.
  process(:store) do |io, ctx|
    versions = { original: io }
    io.download do |original|
      unless Rails.env.test?
        versions = VideoService::ResizePrivate.new(versions, original).call!
      end
      ImagesService::AddMetadataToImage.new(original, ctx, io.metadata).call!
    end

    versions
  end

  Attacher.promote_block do
    ShrineWorker::Promote.perform_async(self.class.name, record.class.name, record.id, name, file_data)
  end
  Shrine::Attacher.destroy_block do
    ShrineWorker::Destroy.perform_async(self.class.name, data)
  end
end
