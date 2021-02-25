import {imageAlbumStore} from './store';
import {shortFileName} from '../../lib/utils/string/short-file-name';
import {useState} from '@hookstate/core';
import GalleryImageFile from './gallery-image-file';
import GalleryVideoFile from './gallery-video-file';

export default function GalleryListItem({data: galleryElement}) {
  const state = useState(imageAlbumStore);
  const cellHeight = '150px';
  const imageHeight = '122px';
  const {realFileName} = galleryElement.element;

  if (galleryElement.destroyed) {
    return null;
  }

  return (
    <div style={{height: cellHeight}}>
      <div className="text-center text-xs">
        {shortFileName(realFileName, 10)}
      </div>

      {
        galleryElement.element.type === 'imagefile' &&
          <GalleryImageFile state={state} galleryElement={galleryElement} imageHeight={imageHeight}/>
      }

      {
        galleryElement.element.type === 'videofile' &&
          <GalleryVideoFile state={state} galleryElement={galleryElement} imageHeight={imageHeight}/>
      }
    </div>
  );
}
