# frozen_string_literal: true

module AttachmentsService
  class Attach
    IMAGES_EXTENSIONS = %w(jpg jpeg png webp tiff).freeze
    attr_reader :files, :subject, :album_name, :is_private

    def initialize(subject, files, album_name, is_private)
      @subject = subject
      @files = files
      @album_name = album_name
      @is_private = is_private
    end

    def call!
      return if files.blank?
      ImageFile.transaction do
        files.each do |file|
          next unless File.exist?(file.path)
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
        attachment = ImageFile.create!(image: File.open(file.path), private: is_private, real_file_name: file.name, md5_checksum: file.md5)
        GalleryElement.create(element: attachment, image_album: image_album)
        AttachedFile.create!(attachment: attachment, subject: subject)
      end

      def get_extension(file)
        file.name.split(".").last.downcase
      end

      def image_album
        @image_album ||= ImageAlbum.find_or_create_by(name: album_name)
      end
  end
end
