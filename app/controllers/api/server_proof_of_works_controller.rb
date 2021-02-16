# frozen_string_literal: true

# external use
module Api
  class ServerProofOfWorksController < BaseController
    before_action :verify_node_request

    def show
      result = ServerProofOfWorkService::Solve.new(permitted_params).call!
      render json: { test: result }
    end

    def permitted_params
      params.require(:test).permit(:sign_string, multiply: [])
    end
  end
end
