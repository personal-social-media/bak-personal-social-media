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
        width: metadata.try(:[], "image_width"),
        height: metadata.try(:[], "image_height")
      }
    }
  end
end
