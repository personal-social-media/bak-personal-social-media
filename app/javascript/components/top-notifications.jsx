import {useState} from '@hookstate/core';
import ActionCable from './utils/action-cable';
import Bugsnag from './utils/bugsnag';
import NotificationsActionCableEvents from './notifications/action-cable-events';
import OpenNotificationsList from './top-notifications/open-notification-list';
import TopNotificationsIcon from './top-notifications/icon';
import FloatingNotification from "./notifications/floating-notification";

export default function TopNotifications({notifications_not_seen_count: notificationsNotSeenCount}) {
  const state = useState({firstTimeOpened: false, notificationsNotSeenCount, opened: false, latestNotification: null});

  return (
    <Bugsnag>
      <ActionCable>
        <NotificationsActionCableEvents state={state}>
          <OpenNotificationsList state={state}>
            <TopNotificationsIcon notificationsNotSeenCount={state.notificationsNotSeenCount}/>
          </OpenNotificationsList>
          <FloatingNotification state={state}/>
        </NotificationsActionCableEvents>
      </ActionCable>
    </Bugsnag>
  );
}
