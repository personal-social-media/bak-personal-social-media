# frozen_string_literal: true

module Api
  class ReactionsController < BaseController
    before_action :verify_node_request
    before_action :require_friend

    def create
    end

    def destroy
    end
  end
end
