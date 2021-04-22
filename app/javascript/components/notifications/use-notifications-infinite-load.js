import {feedBackError} from '../../events/feedback';
import {fetchNotifications} from './store';
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
    if (existing) return;
    loadedNotificationsIndexes.push(newIndex);

    try {
      const {data: {notifications}} = await fetchNotifications(startIndex, endIndex);
      state.notifications.merge(notifications);
    } catch (e) {
      feedBackError('unable to fetch notifications');
    }
  };

  const maybeLoadMore = useRef(useInfiniteLoader(fetchMoreItems, {
    isItemLoaded: (index, items) => {
      // console.log(index, items);
      return false;
      // const res =  !!items[index].id;
      // console.log(index);
      // console.log(res);
      // return res;
    },
    totalItems: notificationsCount + 1,
  }));

  return {maybeLoadMore};
}
