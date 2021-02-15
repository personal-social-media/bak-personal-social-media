import {findIndex} from 'lodash';
import {imageAlbumStore} from '../store';
import {useHotkeys} from 'react-hotkeys-hook';
import {useState} from '@hookstate/core';

export default function ImageAlbumFocusControls({children}) {
  const state = useState(imageAlbumStore);
  const currentGalleryElement = state.currentGalleryElement.get();
  const galleryElements = state.galleryElements.get();

  useHotkeys('left', () => {
    goBack();
  });

  useHotkeys('right', () => {
    goNext();
  });

  function goBack(e) {
    e?.preventDefault();
    const index = findIndex(galleryElements, (el) => {
      return el.id === currentGalleryElement.id;
    });
    let nextIndex = index - 1;
    if (nextIndex === -1) nextIndex = galleryElements.length - 1;
    state.merge({
      currentGalleryElement: galleryElements[nextIndex],
    });
  }

  function goNext(e) {
    e?.preventDefault();
    const index = findIndex(galleryElements, (el) => {
      return el.id === currentGalleryElement.id;
    });
    let nextIndex = index + 1;
    if (nextIndex === galleryElements.length) nextIndex = 0;

    state.merge({
      currentGalleryElement: galleryElements[nextIndex],
    });
  }

  return (
    <div className="flex justify-between">
      <div className="mt-64 pr-4">
        <button onClick={goBack} className="focus:no-outline">
          <i className="fa fa-arrow-left fa-3x text-gray-700 hover:text-gray-600"></i>
        </button>
      </div>
      <div>
        {children}
      </div>
      <div className="mt-64 pl-3">
        <button onClick={goNext} className="focus:no-outline">
          <i className="fa fa-arrow-right fa-3x text-gray-700 hover:text-gray-600"></i>
        </button>
      </div>
    </div>
  );
}
