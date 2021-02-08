# frozen_string_literal: true

module FilesSpecHelper
  def sample_image
    Rails.root.join("spec/support/resources/image.png").to_s
  end

  def sample_image_tmp
    Tempfile.new(%w[image .png]).tap do |t|
      t.write(File.read(sample_image))
      t.rewind
    end
  end
end
