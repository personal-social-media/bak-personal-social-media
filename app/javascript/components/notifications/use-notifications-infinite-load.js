import {addDataToNotifications} from './notifications/get-url-and-message-for-notification';
import {feedBackError} from '../../events/feedback';
import {fetchNotifications} from './store';
import {isEmpty} from 'lodash';
import {useInfiniteLoader} from 'masonic';
import {useRef} from 'react';

let loadedNotificationsIndexes = [];
export function resetLoadedNotificationsIndexes() {
  loadedNotificationsIndexes = [];
}

export function useNotificationsInfiniteLoad({state, notificationsCount}) {
  const fetchMoreItems = async (startIndex, endIndex) => {
    const newIndex = {endIndex, startIndex};
    const existing = loadedNotificationsIndexes.find((el) => {
      return el.startIndex === newIndex.startIndex && el.endIndex === newIndex.endIndex;
    });
    if (existing || startIndex === endIndex) return;
    loadedNotificationsIndexes.push(newIndex);

    try {
      const {data: {notifications}} = await fetchNotifications(startIndex, endIndex);
      const improvedNotifications = notifications.map((n) => addDataToNotifications(n));
      state.notifications.merge(improvedNotifications);
    } catch (e) {
      feedBackError('unable to fetch notifications');
    }
  };

  const maybeLoadMore = useRef(useInfiniteLoader(fetchMoreItems, {
    isItemLoaded: (index, items) => {
      return !isEmpty(items[index]);
    },
    totalItems: notificationsCount + 1,
  }));

  return {maybeLoadMore};
}
