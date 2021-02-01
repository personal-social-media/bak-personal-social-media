# frozen_string_literal: true

module AttachmentsService
  class Attach
    IMAGES_EXTENSIONS = %w(jpg jpeg png webp tiff).freeze
    attr_reader :files, :subject, :album_name

    def initialize(subject, files, album_name)
      @subject = subject
      @files = files
      @album_name = album_name
    end

    def call!
      return if files.blank?
      ImageFile.transaction do
        files.each do |file|
          extension = get_extension(file)
          next handle_image(file) if check_if_image?(extension)
        end
      end
    end

    private
      def check_if_image?(extension)
        IMAGES_EXTENSIONS.include?(extension)
      end

      def handle_image(file)
        attachment = ImageFile.create!(image: file, image_album: image_album)
        AttachedFile.create!(attachment: attachment, subject: subject)
      end

      def get_extension(file)
        file.original_filename.split(".").last.downcase
      end

      def image_album
        @image_album ||= ImageAlbum.find_or_create_by(name: album_name)
      end
  end
end
