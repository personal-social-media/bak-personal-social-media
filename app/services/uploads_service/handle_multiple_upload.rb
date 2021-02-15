# frozen_string_literal: true

module UploadsService
  class HandleMultipleUpload
    attr_reader :param_field

    def initialize(param_field)
      @param_field = param_field
    end

    def call!
      param_field.map do |h|
        UploadedFile.new(h[".path"], h[".md5"], h[".name"])
      end
    end
  end
end
