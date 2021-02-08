# frozen_string_literal: true

module UploadsHelper
  def all_uploaded_image_urls(image)
    {
      desktop: root_path + image.image_url(:desktop),
      mobile: root_path + image.image_url(:mobile),
      thumbnail: root_path + image.image_url(:thumbnail),
    }
  end

  def url_image_for_device(image)
    type = case request.headers["Client"]
           when "desktop"
             :desktop
           else
             :mobile
    end
    root_path + image.image_url(type)
  end

  def url_image_for_device_hash(hash)
    type = case request.headers["Client"]
           when "desktop"
             "desktop"
           else
             "mobile"
    end
    hash[type]
  end


  def root_path
    @root_path ||= Rails.application.secrets.dig(:load_balancer_address)
  end
end
