# frozen_string_literal: true

class ImageFilePresenter
  include UploadsHelper
  attr_reader :request

  def initialize(image_file, request)
    @image_file = image_file
    @request = request
  end

  def render
    i = @image_file
    metadata = i.metadata

    {
      url: url_for_device(i),
      size: {
        width: metadata["image_width"],
        height: metadata["image_height"]
      }
    }
  end
end
