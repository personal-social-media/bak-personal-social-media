# frozen_string_literal: true

module Api
  class ProfilesController < BaseController
    include NodeVerifyRequest
    include IdentityService::SignedRequest
    before_action :verify_node_request
    before_action :verify_not_blocked

    def show
      @profile = Profile.first
      @post_count = Post.count
      @friends_count = PeerInfo.active.count
      return head 404 if @profile.blank?
      @public_key = public_key
    end

    def ignore_register
      true
    end

    helper_method :is_friend?
  end
end
