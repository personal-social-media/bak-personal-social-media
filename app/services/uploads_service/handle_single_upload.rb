# frozen_string_literal: true

module UploadsService
  class HandleSingleUpload
    attr_reader :param_field

    def initialize(param_field)
      @param_field = param_field
    end

    def call!
      UploadedFile.new(param_field[".path"], param_field[".md5"], param_field[".name"])
    end
  end
end
