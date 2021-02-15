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
end


RSpec.configure do |config|
  config.after(:suite) do
    `rm /tmp/sample-test-image-*`
  end
end
