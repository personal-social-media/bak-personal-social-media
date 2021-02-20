import {MasonryScroller, useContainerPosition, usePositioner, useResizeObserver} from 'masonic';
import {imageAlbumStore} from './store';
import {useRef} from 'react';
import {useState} from '@hookstate/core';
import GalleryListItem from './gallery-list-item';
import useWindowSize from '../../lib/hooks/use-window-size';

export default function GalleryList() {
  const state = useState(imageAlbumStore);
  const galleryElements = state.galleryElements.get();
  const {isMobile, height: windowWidth, width: windowHeight} = useWindowSize();
  const containerRef = useRef(null);
  const columns = isMobile ? 2 : 12;

  const {offset, width} = useContainerPosition(containerRef, [
    windowWidth,
    windowHeight,
  ]);

  const positioner = usePositioner(
      {columnCount: columns, columnGutter: 4, estimateHeight: 150, width},
      []);
  const resizeObserver = useResizeObserver(positioner);

  return (
    <MasonryScroller
      positioner={positioner}
      resizeObserver={resizeObserver}
      containerRef={containerRef}
      items={galleryElements}
      height={windowHeight}
      offset={offset}
      render={GalleryListItem}
    />
  );
}
