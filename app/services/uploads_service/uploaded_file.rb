# frozen_string_literal: true

module UploadsService
  class UploadedFile
    attr_reader :path, :md5, :name
    def initialize(path, md5, name)
      @path = path
      @md5 = md5
      @name = name
    end
  end
end
