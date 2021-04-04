# frozen_string_literal: true

module SyncService
  module MediaVariants
    def get_variants_for_image(image)
      {
        original: image.image_url(:original),
        mobile: image.image_url(:mobile),
        thumbnail: image.image_url(:thumbnail),
        size: {
          width: image.metadata.try(:[], "image_width").to_s,
          height: image.metadata.try(:[], "image_height").to_s
        }
      }
    end

    def get_variants_for_video(video)
      {
        original: video.video_url(:original),
        original_screenshot: video.video_url(:original_screenshot),
        thumbnail_screenshot: video.video_url(:mobile),
        short: video.video_url(:thumbnail),
        size: {
          width: video.metadata.try(:[], "image_width").to_s,
          height: video.metadata.try(:[], "image_height").to_s
        }
      }
    end
  end
end
