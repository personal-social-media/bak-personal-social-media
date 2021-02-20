import {imageAlbumStore} from './store';
import {useState} from '@hookstate/core';
import GalleryImageFile from './gallery-image-file';
import GalleryVideoFile from './gallery-video-file';

export default function GalleryListItem({data: galleryElement}) {
  const state = useState(imageAlbumStore);
  const cellHeight = '150px';

  if (galleryElement.destroyed) {
    return null;
  }

  return (
    <div style={{height: cellHeight}}>
      {
        galleryElement.element.type === 'imagefile' &&
          <GalleryImageFile state={state} galleryElement={galleryElement} cellHeight={cellHeight}/>
      }

      {
        galleryElement.element.type === 'videofile' &&
          <GalleryVideoFile state={state} galleryElement={galleryElement} cellHeight={cellHeight}/>
      }
    </div>
  );
}
