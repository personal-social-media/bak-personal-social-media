# frozen_string_literal: true

module AttachmentsService
  class Attach
    attr_reader :files, :subject, :album_name, :is_private, :output_files, :remove_existing

    def initialize(subject, files, album_name, is_private, remove_existing: false)
      @subject = subject
      @files = files
      @album_name = album_name
      @is_private = is_private
      @remove_existing = remove_existing
      @output_files = []
    end

    def call!
      return if files.blank?
      ImageFile.transaction do
        files.each do |file|
          next unless File.exist?(file.path)
          extension = get_extension(file)
          next handle_image(file) if check_if_image?(extension)
          next handle_video(file) if check_if_video?(extension)
        end
      end
      self
    end

    private
      def check_if_image?(extension)
        ImageFile::IMAGES_EXTENSIONS.include?(extension)
      end

      def check_if_video?(extension)
        VideoFile::IMAGES_EXTENSIONS.include?(extension)
      end

      def handle_video(file)
        attachment = VideoFile.create!(video: File.open(file.path), private: is_private, real_file_name: file.name, md5_checksum: file.md5)
        gallery_element = GalleryElement.create(element: attachment, image_album: image_album)
        attached_file = subject.present? ? AttachedFile.create!(attachment: attachment, subject: subject) : nil
        clear_existing(attached_file, VideoFile)

        output_files.push(
          attachment: attachment,
          gallery_element: gallery_element,
          attached_file: attached_file
        )
      end

      def handle_image(file)
        attachment = ImageFile.create!(image: File.open(file.path), private: is_private, real_file_name: file.name, md5_checksum: file.md5)
        gallery_element = GalleryElement.create(element: attachment, image_album: image_album)
        attached_file = subject.present? ? AttachedFile.create!(attachment: attachment, subject: subject) : nil
        clear_existing(attached_file, ImageFile)

        output_files.push(
          attachment: attachment,
          gallery_element: gallery_element,
          attached_file: attached_file
        )
      end

      def clear_existing(new, klass)
        return unless remove_existing
        AttachedFile.where(subject: subject, attachment_type: klass.name).where.not(id: new.id).destroy_all
      end

      def get_extension(file)
        file.name.split(".").last.downcase
      end

      def image_album
        @image_album ||= ImageAlbum.find_or_create_by(name: album_name)
      end
  end
end
