# frozen_string_literal: true

# internal use
module Client
  class CacheReactionsController < BaseController
    before_action :require_current_user

    def index
      @cache_reactions = CacheReactionsService::Index.new(params.permit![:searchSearchListItem])
    end
  end
end
