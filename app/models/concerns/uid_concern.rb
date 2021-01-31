# frozen_string_literal: true

module UidConcern
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  private
    def generate_uid
      self.uid = SecureRandom.hex(24)
    end
end
