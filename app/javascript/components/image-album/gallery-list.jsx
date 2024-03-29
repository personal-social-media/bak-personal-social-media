import {MasonryScroller, useContainerPosition, usePositioner, useResizeObserver} from 'masonic';
import {imageAlbumStore} from './store';
import {useCallback, useRef} from 'react';
import {useGalleryInfiniteLoad} from './use-gallery-infinite-load';
import {useState} from '@hookstate/core';
import GalleryListItem from './gallery-list-item';
import useWindowSize from '../../lib/hooks/use-window-size';

export default function GalleryList({imageAlbumId, galleryElementsCount}) {
  const state = useState(imageAlbumStore);
  const galleryElements = state.galleryElements;
  const {isMobile, height: windowHeight, width: windowWidth} = useWindowSize();
  const containerRef = useRef(null);
  const columns = isMobile ? 2 : 12;

  const {offset, width} = useContainerPosition(containerRef, [
    windowHeight,
    windowWidth,
  ]);

  const positioner = usePositioner(
      {columnCount: columns, columnGutter: 4, estimateHeight: 100, width},
      []);
  const resizeObserver = useResizeObserver(positioner);

  const {maybeLoadMore} = useGalleryInfiniteLoad({galleryElementsCount, imageAlbumId, state});

  const GalleryListItemWrapper = useCallback((props) => {
    return (
      <GalleryListItem {...props} state={state}/>
    );
  }, []); // eslint-disable-line react-hooks/exhaustive-deps

  return (
    <MasonryScroller
      positioner={positioner}
      resizeObserver={resizeObserver}
      containerRef={containerRef}
      items={galleryElements}
      height={windowHeight}
      offset={offset}
      render={GalleryListItemWrapper}
      overscanBy={columns * 3}
      onRender={maybeLoadMore.current}
      className="outline-none"
    />
  );
}
