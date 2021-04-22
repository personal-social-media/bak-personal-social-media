import {List, useContainerPosition, usePositioner, useScroller} from 'masonic';
import {notificationsStore} from './store';
import {useNotificationsInfiniteLoad} from './use-notifications-infinite-load';
import {useState} from '@hookstate/core';
import NotificationItem from './notification-item';
import useWindowSize from '../../lib/hooks/use-window-size';

export default function NotificationsList({containerRef}) {
  const state = useState(notificationsStore);
  const notifications = state.notifications;
  const notificationsCount = state.notificationsCount.get();
  console.log(containerRef);

  const {height: windowHeight, width: windowWidth} = useWindowSize();
  const {offset, width} = useContainerPosition(containerRef, [
    windowWidth,
    windowHeight,
  ]);
  const {scrollTop, isScrolling} = useScroller(offset);
  const positioner = usePositioner({width});
  const {maybeLoadMore} = useNotificationsInfiniteLoad({notificationsCount, state});
  console.log(scrollTop, isScrolling);

  return (
    <List
      items={notifications}
      positioner={positioner}
      // The distance in px between the top of the document and the top of the
      // masonry grid container
      offset={offset}
      // The height of the virtualization window
      height={windowHeight}
      // Forwards the ref to the masonry container element
      containerRef={containerRef}
      onRender={maybeLoadMore.current}
      render={NotificationItem}
      scrollTop={scrollTop}
      isScrolling={isScrolling}
    />
  );

  //
  // const NotificationItemWrapper = useCallback((props) => {
  //   return (
  //     <NotificationItem {...props} state={state}/>
  //   );
  // }, []); // eslint-disable-line react-hooks/exhaustive-deps
  //
  // const {maybeLoadMore} = useNotificationsInfiniteLoad({notificationsCount, state});
  // const {height: windowHeight, width: windowWidth} = useWindowSize()
  // console.log(windowHeight, windowWidth);
  // const {offset, width} = useContainerPosition(
  //   containerRef,
  //   // In this example, we want to recalculate the `offset` and `width`
  //   // any time the size of the window changes
  //   [windowWidth, windowHeight]
  // );
  //
  //
  // return (
  //   <List
  //     items={notifications}
  //     render={NotificationItemWrapper}
  //     onRender={maybeLoadMore.current}
  //     rowGutter={32}
  //     width={width}
  //     height={windowHeight}
  //     containerRef={containerRef}
  //     offset={offset}
  //   />
  // );
}
