# frozen_string_literal: true

class Person::AvatarComponent < ViewComponent::Base
  attr_reader :url, :options
  def initialize(url:, **options)
    @url = url
    @options = options
  end

  def real_url
    url || image_path("profiles/placeholder.svg")
  end
end
