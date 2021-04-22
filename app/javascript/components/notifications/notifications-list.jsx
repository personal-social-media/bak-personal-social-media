import {MasonryScroller, useContainerPosition, usePositioner, useResizeObserver} from 'masonic';
import {getProperties} from '../../lib/utils/get-properties';
import {notificationsStore} from './store';
import {useCallback, useRef} from 'react';
import {useNotificationsInfiniteLoad} from './use-notifications-infinite-load';
import {useState} from '@hookstate/core';
import NotificationItem from './notification-item';
import useWindowSize from '../../lib/hooks/use-window-size';

export default function NotificationsList() {
  const state = useState(notificationsStore);
  const notifications = state.notifications;
  const {notificationsCount} = getProperties(state, 'notificationsCount');
  const {height: windowHeight, width: windowWidth} = useWindowSize();
  const containerRef = useRef(null);
  const columns = 1;

  const {offset, width} = useContainerPosition(containerRef, [
    windowHeight,
    windowWidth,
  ]);

  const positioner = usePositioner(
      {columnCount: columns, width},
      []);
  const resizeObserver = useResizeObserver(positioner);

  const {maybeLoadMore} = useNotificationsInfiniteLoad({notificationsCount, state});

  const NotificationItemWrapper = useCallback((props) => {
    return (
      <NotificationItem {...props} state={state}/>
    );
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <MasonryScroller
      positioner={positioner}
      resizeObserver={resizeObserver}
      containerRef={containerRef}
      items={notifications}
      height={windowHeight}
      offset={offset}
      render={NotificationItemWrapper}
      onRender={maybeLoadMore.current}
      className="outline-none min-h-screen"
      itemHeightEstimate={75}
    />
  );
}
