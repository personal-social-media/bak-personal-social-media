# frozen_string_literal: true

module AttachmentsService
  class UrlFor
    class UrlForError < Exception; end
    attr_reader :object, :request

    def initialize(object, request)
      @object = object
      @request = request
    end

    def all_urls
      call_delegate_method(:all_urls)
    end

    def url_for_device
      call_delegate_method(:url_for_device)
    end

    def url_for_device_hash(hash)
      call_delegate_method(:url_for_device_hash, hash)
    end

    private
      def call_delegate_method(name, **arguments)
        return AttachmentsService::UrlFor::ImageUrl.new(object, request).send(name, **arguments) if is_image?
        return AttachmentsService::UrlFor::VideoUrl.new(object, request).send(name, **arguments) if is_image?

        raise UrlForError, "invalid object: #{object.class.name}"
      end

      def is_image?
        object.is_a?(ImageFile)
      end

      def is_video?
        object.is_a?(VideoFile)
      end
  end
end
