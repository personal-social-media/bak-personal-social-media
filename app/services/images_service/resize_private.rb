# frozen_string_literal: true

module ImagesService
  class ResizePrivate
    extend Memoist

    attr_reader :versions, :original
    def initialize(versions, original)
      @versions = versions
      @original = original
    end

    def call!
      versions.tap do |v|
        v[:original] = pipeline.saver(quality: 95).resize_to_limit!(4096, 4096)
        v[:thumbnail] = pipeline.saver(quality: 75).resize_to_limit!(120, 120)
      end
    end

    memoize def pipeline
      ImageProcessing::Vips.source(original)
    end
  end
end
