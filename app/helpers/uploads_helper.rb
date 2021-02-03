# frozen_string_literal: true

module UploadsHelper
  extend Memoist
  def all_uploaded_image_urls(image)
    {
      desktop: root + image.image_url(:desktop),
      mobile: root + image.image_url(:mobile),
      thumbnail: root + image.image_url(:thumbnail),
    }
  end

  def url_image_for_device(image)
    type = case request.headers["Client"]
           when "desktop"
             :desktop
           else
             :mobile
    end
    root + image.image_url(type)
  end

  memoize def root
    Rails.application.secrets.dig(:load_balancer_address)
  end
end
