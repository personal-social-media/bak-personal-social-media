# frozen_string_literal: true

class Person::AvatarComponent < ViewComponent::Base
  attr_reader :url, :class_name
  def initialize(url:, class_name: "")
    @url = url
    @class_name = class_name
  end

  def real_url
    url || image_path("profiles/placeholder.svg")
  end
end
