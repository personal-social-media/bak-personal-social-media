# frozen_string_literal: true

module UidConcern
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  private
    def generate_uid
      new = SecureRandom.hex(24)
      return self.uid = new unless Rails.env.test?
      self.uid ||= new
    end
end
