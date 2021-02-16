# frozen_string_literal: true

# external use
module Api
  class ReactionsController < BaseController
    before_action :verify_node_request
    before_action :require_friend
    before_action :verify_not_blocked

    def create
    end

    def destroy
    end
  end
end
