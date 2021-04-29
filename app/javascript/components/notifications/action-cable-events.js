import {addDataToNotifications} from './notifications/get-url-and-message-for-notification';
import {notificationsStore} from './store';
import {useActionCable} from '../../lib/hooks/use-action-cable';
import {useState} from '@hookstate/core';
import camelize from '../../lib/format/camelize';

export default function NotificationsActionCableEvents({children, state}) {
  const notificationsStoreState = useState(notificationsStore);

  const channelHandlers = {
    received({notification: unformattedNotification}) {
      const notification = camelize(unformattedNotification);
      const improvedNotification = addDataToNotifications(notification);
      state.merge((s) => {
        return {
          notificationsNotSeenCount: s.notificationsNotSeenCount + 1,
          latestNotification: s.latestNotification === null ? improvedNotification : null
        };
      });

      if (notificationsStoreState.notifications.get() === null) return;

      notificationsStoreState.notifications.set((n) => {
        n.splice(0, 0, improvedNotification);
        return n;
      });
    },
  };

  const channelParams = {channel: 'NotificationsChannel'};
  useActionCable(channelParams, channelHandlers);

  return children;
}
