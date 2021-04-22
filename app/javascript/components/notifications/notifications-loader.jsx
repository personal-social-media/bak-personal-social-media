import {addDataToNotifications} from './notifications/get-url-and-message-for-notification';
import {fetchNotifications, notificationsStore} from './store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';

export default function NotificationsLoader({children}) {
  const state = useState(notificationsStore);

  useEffect(() => {
    fetchNotifications().then(({data: {notifications, notificationsCount}}) => {
      const improvedNotifications = notifications.map((n) => addDataToNotifications(n));
      state.merge({notifications: improvedNotifications, notificationsCount});
    });
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  if (state.notifications.get() === null) return null;

  return children;
}
