# frozen_string_literal: true

module PrivacyConcern
  extend ActiveSupport::Concern

  included do
    str_enum :privacy, %i(public_access private_access friends_only)
  end
end
