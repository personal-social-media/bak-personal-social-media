import {getProperties} from '../../lib/utils/get-properties';
import {notificationsStore} from './store';
import {useCallback} from 'react';
import {useDimensions} from '../../lib/hooks/use-dimensions';
import {useMasonry, usePositioner, useResizeObserver} from 'masonic';
import {useNotificationsInfiniteLoad} from './use-notifications-infinite-load';
import {useScroller} from 'mini-virtual-list';
import {useState} from '@hookstate/core';
import NotificationItem from './notification-item';

export default function NotificationsListTop({topContainerRef}) {
  const columnCount = 1;
  const state = useState(notificationsStore);
  const notifications = state.notifications;
  const {notificationsCount} = getProperties(state, 'notificationsCount');
  const {scrollTop, isScrolling} = useScroller(topContainerRef);

  const {width, height} = useDimensions(topContainerRef, []);
  const positioner = usePositioner({columnCount, estimateHeight: 75, width: width - 20});
  const resizeObserver = useResizeObserver(positioner);

  const NotificationItemWrapper = useCallback((props) => {
    return (
      <NotificationItem {...props} state={state}/>
    );
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  const {maybeLoadMore} = useNotificationsInfiniteLoad({notificationsCount, state});


  return useMasonry({
    columnCount,
    height,
    isScrolling,
    itemHeightEstimate: 75,
    items: notifications,
    onRender: maybeLoadMore.current,
    positioner,
    render: NotificationItemWrapper,
    resizeObserver,
    scrollTop,
  });
}
