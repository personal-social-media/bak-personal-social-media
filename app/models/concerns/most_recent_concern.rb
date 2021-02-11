# frozen_string_literal: true

module MostRecentConcern
  extend ActiveSupport::Concern

  included do
    after_create :mark_as_most_recent
  end

  private
    def mark_as_most_recent
      most_recent_query.order(id: :desc).offset(most_recent_limit).update_all(most_recent: false)
      most_recent_query.order(id: :desc).limit(most_recent_limit).update_all(most_recent: true)
    end
end
