import {imageAlbumStore} from './store';
import {useState} from '@hookstate/core';
import FocusedModalPicture from './focused-modal/picture';
import ImageAlbumFocusControls from './focused-modal/controls';
import ImageInformation from './focused-modal/information';
import Modal from '../utils/modal';

export default function ImageAlbumFocusedModal() {
  const state = useState(imageAlbumStore);
  const currentGalleryElement = state.currentGalleryElement.get();

  function setModalOpened(modalOpened) {
    state.merge({
      modalOpened,
    });
  }

  return (
    <Modal opened={state.modalOpened.get()} setOpened={setModalOpened}>
      {
        currentGalleryElement && <ImageAlbumFocusControls>
          <div className="pb-10">
            <ImageInformation currentGalleryElement={currentGalleryElement}/>
          </div>
          <FocusedModalPicture currentGalleryElement={currentGalleryElement}/>
        </ImageAlbumFocusControls>
      }
    </Modal>
  );
}
