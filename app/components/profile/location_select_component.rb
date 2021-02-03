# frozen_string_literal: true

class Profile::LocationSelectComponent < ViewComponent::Base
  include StimulusHelper
  attr_reader :country, :city, :f
  def initialize(country:, city:, f:)
    @country = country
    @city = city
    @f = f
  end
end
