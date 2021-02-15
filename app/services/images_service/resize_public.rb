# frozen_string_literal: true

module ImagesService
  class ResizePublic
    extend Memoist

    attr_reader :versions, :original
    def initialize(versions, original)
      @versions = versions
      @original = original
    end

    def call!
      versions.tap do |v|
        v[:original] = original_image
        v[:mobile] = mobile
        v[:thumbnail] = thumbnail
      end
    end

    private
      def original_image
        pipeline.saver(strip: true, quality: 89).resize_to_limit!(1600, 1600)
      end

      def mobile
        pipeline.saver(strip: true, quality: 88).resize_to_limit!(720, 720)
      end

      def thumbnail
        pipeline.saver(strip: true, quality: 75).resize_to_limit!(160, 160)
      end

      memoize def pipeline
        ImageProcessing::Vips.source(original).convert("webp")
      end
  end
end
