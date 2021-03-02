import {
  FilesPendingContext,
  defaultImageAlbumStore,
  fetchGalleryElements,
  filesPendingContextDefault,
  imageAlbumStore,
} from './image-album/store';
import {feedBackError} from '../events/feedback';
import {useState as reactUseState} from 'react';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import GalleryList from './image-album/gallery-list';
import ImageAlbumFocusedModal from './image-album/focused-modal';
import ImageAlbumUpload from './image-album/upload';

export default function ImageAlbum({imageAlbum: {id: imageAlbumId, manualUpload}}) {
  const state = useState(imageAlbumStore);
  const [pendingFiles, setPendingFiles] = reactUseState(filesPendingContextDefault);

  useEffect(() => {
    fetchGalleryElements(imageAlbumId).then(({data: {galleryElements}}) => {
      state.merge({
        galleryElements,
      });
    }).catch(() => {
      feedBackError('unable to fetch images');
    });

    return () => {
      state.merge({
        ...defaultImageAlbumStore,
      });
    };
  }, [imageAlbumId]); // eslint-disable-line react-hooks/exhaustive-deps

  if (!state.galleryElements.get()) {
    return (
      <div>
        Loading...
      </div>
    );
  }

  return (
    <FilesPendingContext.Provider value={[pendingFiles, setPendingFiles]}>
      <div>
        {
          manualUpload && <div className="mb-4 flex justify-end">
            <ImageAlbumUpload imageAlbumId={imageAlbumId}/>
          </div>
        }

        <GalleryList/>

        <ImageAlbumFocusedModal/>
      </div>
    </FilesPendingContext.Provider>
  );
}
