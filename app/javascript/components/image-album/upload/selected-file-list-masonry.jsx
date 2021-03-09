import {useMasonry, usePositioner, useResizeObserver} from 'masonic';
import {useScroller} from 'mini-virtual-list';

export default function SelectedFilesListMasonry({columnWidth, columnGutter, columnCount, items, width, height, topContainerRef, ...props}) {
  const {scrollTop, isScrolling} = useScroller(topContainerRef);
  const positioner = usePositioner({columnCount, columnGutter, columnWidth, estimateHeight: 140, width});
  const resizeObserver = useResizeObserver(positioner);

  return useMasonry({
    height,
    isScrolling,
    items,
    overscanBy: columnCount * 3,
    positioner,
    resizeObserver,
    scrollTop,
    ...props,
  });
}
