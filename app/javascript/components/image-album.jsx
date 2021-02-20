import {FilesPendingContext, fetchGalleryElements, imageAlbumStore} from './image-album/store';
import {feedBackError} from '../events/feedback';
import {useState as reactUseState} from 'react';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import GalleryList from './image-album/gallery-list';
import ImageAlbumFocusedModal from './image-album/focused-modal';
import ImageAlbumUpload from './image-album/upload';

export default function ImageAlbum({image_album_id: imageAlbumId}) {
  const state = useState(imageAlbumStore);
  const [pendingFilesForUpload, setPendingFilesForUpload] = reactUseState([]);

  useEffect(() => {
    fetchGalleryElements(imageAlbumId).then(({data: {galleryElements}}) => {
      state.merge({
        galleryElements,
      });
    }).catch(() => {
      feedBackError('unable to fetch images');
    });
  }, [imageAlbumId]); // eslint-disable-line react-hooks/exhaustive-deps

  if (!state.galleryElements.get()) {
    return (
      <div>
        Loading...
      </div>
    );
  }

  return (
    <FilesPendingContext.Provider value={[pendingFilesForUpload, setPendingFilesForUpload]}>
      <div>
        <div className="mb-4 flex justify-end">
          <ImageAlbumUpload/>
        </div>

        <GalleryList/>

        <ImageAlbumFocusedModal/>
      </div>
    </FilesPendingContext.Provider>
  );
}
