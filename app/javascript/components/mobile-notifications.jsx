import Bugsnag from './utils/bugsnag';
import NotificationsList from './notifications/notifications-list';
import NotificationsLoader from './notifications/notifications-loader';

export default function MobileNotifications() {
  return (
    <Bugsnag>
      <div className="p-4">
        <NotificationsLoader>
          <NotificationsList/>
        </NotificationsLoader>
      </div>
    </Bugsnag>
  );
}
