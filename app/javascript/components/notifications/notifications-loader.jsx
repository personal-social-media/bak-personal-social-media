import {fetchNotifications, notificationsStore} from './store';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';

export default function NotificationsLoader({children}) {
  const state = useState(notificationsStore);

  useEffect(() => {
    fetchNotifications().then(({data: {notifications, notificationsCount}}) => {
      state.merge({notifications, notificationsCount});
    });
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  return children;
}
