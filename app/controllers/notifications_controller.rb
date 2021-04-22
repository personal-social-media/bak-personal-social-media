# frozen_string_literal: true

class NotificationsController < Client::BaseController
  include BulletHelper

  around_action :skip_bullet, only: :index, if: -> { defined?(Bullet) }

  def index
    service = NotificationsService::IndexNotificationsSearch.new(params.permit!).call!
    @notifications = service.notifications
    @messages_count = service.count
    @not_seen_count = service.not_seen_count

  rescue MessagesService::IndexSearch::IndexError => e
    render json: { error: e.message }, status: 422
  end

  def destroy
    scoped_notifications.delete_all
    head :ok
  end

  def mark_as_seen
    scoped_notifications.update_all(seen: true)
    head :ok
  end

  private
    def scoped_notifications
      if params[:ids] == ["all"]
        return Notification.all
      end

      Notification.where(id: params[:ids])
    end
end
