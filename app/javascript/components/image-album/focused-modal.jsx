import {downloadFile} from '../../lib/utils/download-file';
import {imageAlbumStore} from './store';
import {useState} from '@hookstate/core';
import FocusedModalPicture from './focused-modal/picture';
import FocusedModalVideo from './focused-modal/video';
import ImageAlbumFocusControls from './focused-modal/controls';
import ImageInformation from './focused-modal/image-information';
import Modal from '../utils/modal';
import VideoInformation from './focused-modal/video-information';

export default function ImageAlbumFocusedModal() {
  const state = useState(imageAlbumStore);
  const currentGalleryElement = state.currentGalleryElement.get();

  function setModalOpened(modalOpened) {
    state.merge({
      modalOpened,
    });
  }

  function download(e) {
    const {originalUrl, realFileName} = currentGalleryElement.element;
    e.preventDefault();
    downloadFile(originalUrl, realFileName);
  }

  function destroy(e) {
    e.preventDefault();
  }

  return (
    <Modal opened={state.modalOpened.get()} setOpened={setModalOpened}>
      {
        currentGalleryElement && <ImageAlbumFocusControls>
          <div className="pb-10">
            {
              currentGalleryElement.element.type === 'imagefile' &&
              <ImageInformation currentGalleryElement={currentGalleryElement} download={download} destroy={destroy}/>
            }
            {
              currentGalleryElement.element.type === 'videofile' &&
              <VideoInformation currentGalleryElement={currentGalleryElement} download={download} destroy={destroy}/>
            }
          </div>
          {
            currentGalleryElement.element.type === 'imagefile' &&
            <FocusedModalPicture currentGalleryElement={currentGalleryElement}/>
          }

          {
            currentGalleryElement.element.type === 'videofile' &&
            <FocusedModalVideo currentGalleryElement={currentGalleryElement}/>
          }
        </ImageAlbumFocusControls>
      }
    </Modal>
  );
}
