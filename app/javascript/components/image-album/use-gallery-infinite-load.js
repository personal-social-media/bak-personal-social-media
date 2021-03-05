import {feedBackError} from '../../events/feedback';
import {fetchGalleryElements} from './store';
import {useInfiniteLoader} from 'masonic';
import {useRef} from 'react';

let loadedGalleryItemsIndexes = [];
export function resetLoadedGalleryItemsIndexes() {
  loadedGalleryItemsIndexes = [];
}

export function useGalleryInfiniteLoad({state, galleryElementsCount, imageAlbumId}) {
  const fetchMoreItems = async (startIndex, endIndex) => {
    const newIndex = {endIndex, startIndex};
    const existing = loadedGalleryItemsIndexes.find((el) => {
      return el.startIndex === newIndex.startIndex && el.endIndex === newIndex.endIndex;
    });
    if (existing) return;
    loadedGalleryItemsIndexes.push(newIndex);

    try {
      const {data: {galleryElements}} = await fetchGalleryElements(imageAlbumId, startIndex, endIndex);
      state.merge((s) => {
        return {
          galleryElements: [...s.galleryElements, ...galleryElements],
        };
      });
    } catch (e) {
      feedBackError('unable to fetch images');
    }
  };
  const maybeLoadMore = useRef(useInfiniteLoader(fetchMoreItems, {
    isItemLoaded: (index, items) => !!items[index],
    totalItems: galleryElementsCount,
  }));

  return {maybeLoadMore};
}
