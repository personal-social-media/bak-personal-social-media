# frozen_string_literal: true

module PrivacyService
  class PrivacyBaseQuery
    attr_reader :is_friend, :model

    def initialize(model, is_friend)
      @model = model
      @is_friend = is_friend
    end

    def call!
      return model.where(privacy: %i(public_access friends_only)) if is_friend
      model.public_access
    end
  end
end
