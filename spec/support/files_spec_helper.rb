# frozen_string_literal: true

module FilesSpecHelper
  def sample_image
    Rails.root.join("spec/support/resources/image.png").to_s
  end

  def sample_image_tmp
    "/tmp/sample-test-image-#{SecureRandom.hex}.png".tap do |path|
      `cp #{sample_image} #{path}`
    end
  end

  def sample_video
    Rails.root.join("spec/support/resources/video.webm").to_s
  end

  def sample_video_tmp
    "/tmp/sample-test-video-#{SecureRandom.hex}.webm".tap do |path|
      `cp #{sample_video} #{path}`
    end
  end
end


RSpec.configure do |config|
  config.after(:suite) do
    `rm -rf /tmp/sample-test-image-* /tmp/sample-test-video-*`
  end
end
