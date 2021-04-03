# frozen_string_literal: true

module AttachmentsService
  class Attach
    attr_reader :files, :subject, :album_name, :is_private, :output_files, :remove_existing, :album_manual_upload

    def initialize(subject, files, elements_options: {}, album_options: {})
      @subject = subject
      @files = files
      @album_name = album_options[:album_name]
      @is_private = elements_options[:is_private]
      @remove_existing = elements_options[:remove_existing]
      @image_album = album_options[:image_album]
      @album_manual_upload = album_options[:album_manual_upload]

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
        attachment = VideoFile.find_by(md5_checksum: file.md5)
        processing_status = :processing
        if attachment.present?
          processing_status = :processed
        else
          attachment = VideoFile.create!(video: File.open(file.path), private: is_private, real_file_name: file.name, md5_checksum: file.md5)
        end

        gallery_element = GalleryElement.create(element: attachment, image_album: image_album)
        attached_file = subject.present? ? AttachedFile.create!(attachment: attachment, subject: subject, processing_status: processing_status) : nil
        clear_existing(attached_file, VideoFile)

        output_files.push(
          attachment: attachment,
          gallery_element: gallery_element,
          attached_file: attached_file
        )
      end

      def handle_image(file)
        attachment = ImageFile.find_by(md5_checksum: file.md5)
        processing_status = :processing
        if attachment.present?
          processing_status = :processed
        else
          attachment = ImageFile.create!(image: File.open(file.path), private: is_private, real_file_name: file.name, md5_checksum: file.md5)
        end

        gallery_element = GalleryElement.create(element: attachment, image_album: image_album)
        attached_file = subject.present? ? AttachedFile.create!(attachment: attachment, subject: subject, processing_status: processing_status) : nil
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
        @image_album ||= ImageAlbum.find_or_initialize_by(name: album_name).tap do |album|
          album.manual_upload = album_manual_upload
          album.save!
        end
      end
  end
end
