# frozen_string_literal: true

class NotificationsController < Client::BaseController
  def index
    service = NotificationsService::IndexNotificationsSearch.new(params.permit!).call!
    @notifications = service.notifications
    @messages_count = service.count
    @not_seen_count = service.not_seen_count

  rescue MessagesService::IndexSearch::IndexError => e
    render json: { error: e.message }, status: 422
  end

  def destroy
  end

  def mark_as_read
  end

  def scoped_notifications
    if params[:ids] == ["all"]
      return Notification.all
    end

    Notification.where(id: params[:ids])
  end
end
