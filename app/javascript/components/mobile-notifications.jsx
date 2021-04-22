import {useRef} from 'react';
import Bugsnag from './utils/bugsnag';
import NotificationsList from './notifications/notifications-list';
import NotificationsLoader from './notifications/notifications-loader';

export default function MobileNotifications() {
  const containerRef = useRef();
  console.log(containerRef);

  return (
    <Bugsnag>
      <NotificationsLoader>
        <div className="h-screen w-full overflow-x-hidden overflow-y-auto" ref={containerRef}>
          <NotificationsList containerRef={containerRef}/>
        </div>
      </NotificationsLoader>
    </Bugsnag>
  );
}
