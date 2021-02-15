import {AutoSizer} from 'react-virtualized';
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
  const columns = 12;

  useEffect(() => {
    fetchGalleryElements(imageAlbumId).then(({data: {galleryElements}}) => {
      console.log(galleryElements);
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

        <div style={{height: '100vh', width: '100%'}}>
          <AutoSizer>
            {({width, height}) => {
              if (height < 1 || width < 1) return null;
              return <GalleryList realWidth={width / columns} columns={columns} width={width} height={height}/>;
            }}
          </AutoSizer>
        </div>

        <ImageAlbumFocusedModal/>
      </div>
    </FilesPendingContext.Provider>
  );
}
