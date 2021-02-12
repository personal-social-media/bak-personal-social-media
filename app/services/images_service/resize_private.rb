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
        v[:original] = pipeline.resize_to_limit!(4096, 4096).saver(quality: 95)
        v[:thumb] = pipeline.resize_to_limit!(120, 120).saver(quality: 50)
      end
    end

    memoize def pipeline
      ImageProcessing::Vips.source(original)
    end
  end
end
