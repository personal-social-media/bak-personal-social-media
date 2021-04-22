import {localAxios} from '../../http/build-axios';

export function removeGalleryElement(galleryElement) {
  return localAxios.delete(`/gallery_elements/${galleryElement.id.get()}`);
}
