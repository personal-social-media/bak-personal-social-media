import {goBackButton, goNextButton} from '../../../lib/grid/controls';
import {imageAlbumStore} from '../store';
import {useHotkeys} from 'react-hotkeys-hook';
import {useState} from '@hookstate/core';

export default function ImageAlbumFocusControls({children}) {
  const state = useState(imageAlbumStore);
  const {currentGalleryElement, galleryElements} = state;

  useHotkeys('left', () => {
    goBack();
  });

  useHotkeys('right', () => {
    goNext();
  });

  function goBack(e) {
    e?.preventDefault();
    goBackButton(currentGalleryElement, galleryElements, 'id', state,
        'currentGalleryElement', 'destroyed');
  }

  function goNext(e) {
    e?.preventDefault();
    goNextButton(currentGalleryElement, galleryElements, 'id', state,
        'currentGalleryElement', 'destroyed');
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
