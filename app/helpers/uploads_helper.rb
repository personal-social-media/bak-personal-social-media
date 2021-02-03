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

  memoize def root
    Rails.application.secrets(:load_balancer_address)
  end
end
