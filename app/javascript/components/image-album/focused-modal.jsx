import {destroyItem} from '../../lib/grid/controls';
import {downloadFile} from '../../lib/utils/download-file';
import {feedBackError, feedbackSuccess} from '../../events/feedback';
import {imageAlbumStore} from './store';
import {isEmpty} from 'lodash';
import {removeGalleryElement} from '../../lib/actions/gallery-elements/remove-element';
import {useState} from '@hookstate/core';
import FocusedModalPicture from './focused-modal/picture';
import FocusedModalVideo from './focused-modal/video';
import ImageAlbumFocusControls from './focused-modal/controls';
import ImageInformation from './focused-modal/image-information';
import Modal from '../utils/modal';
import VideoInformation from './focused-modal/video-information';

export default function ImageAlbumFocusedModal() {
  const state = useState(imageAlbumStore);
  const currentGalleryElement = state.currentGalleryElement;
  const galleryElements = state.galleryElements;

  function setModalOpened(modalOpened) {
    state.merge({
      modalOpened,
    });
  }

  function download(e) {
    const originalUrl = currentGalleryElement.element.originalUrl.get();
    const realFileName = currentGalleryElement.element.realFileName.get();
    e.preventDefault();
    downloadFile(originalUrl, realFileName);
  }

  async function destroy(e) {
    e.preventDefault();
    try {
      await removeGalleryElement(currentGalleryElement);
    } catch {
      return feedBackError('Unable to remove gallery element');
    }

    destroyItem(currentGalleryElement, galleryElements, 'galleryElements', 'id', state,
        'currentGalleryElement', 'destroyed', 'modalOpened');

    feedbackSuccess('Deleted');
  }

  return (
    <Modal opened={state.modalOpened.get()} setOpened={setModalOpened} modalStyle={{marginTop: '1rem', width: '60%'}}>
      {
        !isEmpty(currentGalleryElement) && <ImageAlbumFocusControls>
          <div className="pb-10">
            {
              currentGalleryElement.element.type.get() === 'imagefile' &&
              <ImageInformation currentGalleryElement={currentGalleryElement} download={download} destroy={destroy}/>
            }
            {
              currentGalleryElement.element.type.get() === 'videofile' &&
              <VideoInformation currentGalleryElement={currentGalleryElement} download={download} destroy={destroy}/>
            }
          </div>
          {
            currentGalleryElement.element.type.get() === 'imagefile' &&
            <FocusedModalPicture currentGalleryElement={currentGalleryElement}/>
          }

          {
            currentGalleryElement.element.type.get() === 'videofile' &&
            <FocusedModalVideo currentGalleryElement={currentGalleryElement}/>
          }
        </ImageAlbumFocusControls>
      }
    </Modal>
  );
}
