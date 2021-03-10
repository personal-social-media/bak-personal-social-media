# frozen_string_literal: true

class VideoFilePresenter
  include UploadsHelper
  attr_reader :request

  def initialize(video_file, request)
    @video_file = video_file
    @request = request
  end

  def render
    v = @video_file
    metadata = v.metadata

    {
      url: url_for_device(v),
      size: {
        width: metadata["image_width"],
        height: metadata["image_height"]
      }
    }
  end
end
