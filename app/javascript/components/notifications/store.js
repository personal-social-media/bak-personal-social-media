import {createState} from '@hookstate/core';
import {isEmpty} from 'lodash';
import {localAxios} from '../../lib/http/build-axios';

export const defaultNotificationsStore = {
  notifications: null,
  notificationsCount: 0,
  notificationsNotSeenCount: 0,
};

export const notificationsStore = createState({
  ...defaultNotificationsStore,
});

export function fetchNotifications(startIndex, endIndex) {
  let url = `/notifications`;
  if (startIndex && endIndex) {
    url += `?start_index=${startIndex}&end_index=${endIndex}`;
  }
  return localAxios.get(url);
}

export function markNotificationsAsSeen(ids) {
  if (isEmpty(ids)) return;

  const url = '/notifications/mark_as_seen';
  return localAxios.patch(url, {ids: ids});
}
