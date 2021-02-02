# frozen_string_literal: true

module Api
  class ProfilesController < BaseController
    include NodeVerifyRequest
    include IdentityService::SignedRequest
    before_action :verify_node_request

    def show
      @profile = Profile.first
      return head 404 if @profile.blank?
      @public_key = public_key
    end

    helper_method :is_friend?
  end
end
