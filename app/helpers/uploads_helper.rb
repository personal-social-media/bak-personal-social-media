# frozen_string_literal: true

module UploadsHelper
  def all_uploaded_urls(media_file)
    AttachmentsService::UrlFor.new(media_file, request).all_urls
  end

  def url_for_device(media_file)
    AttachmentsService::UrlFor.new(media_file, request).url_for_device
  end

  def url_for_device_hash(hash)
    AttachmentsService::UrlFor.new(nil, request).url_for_device_hash(hash)
  end
end
