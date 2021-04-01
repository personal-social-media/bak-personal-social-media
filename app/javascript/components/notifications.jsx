import ActionCable from './utils/action-cable';
import Bugsnag from './utils/bugsnag';
import NotificationsActionCableEvents from './notifications/action-cable-events';

export default function Notifications() {
  return (
    <Bugsnag>
      <ActionCable>
        <NotificationsActionCableEvents>
          ok
        </NotificationsActionCableEvents>
      </ActionCable>
    </Bugsnag>
  );
}
