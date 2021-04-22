# frozen_string_literal: true

module AssetsService
  module AssetsUrl
    def _ctrl
      @_ctrl ||= ApplicationController.new.helpers
    end

    delegate :image_url, to: :_ctrl
  end
end
