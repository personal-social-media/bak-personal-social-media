import {buildLocalAxios} from '../../lib/http/build-axios';
import {createContext} from 'react';
import {createState} from '@hookstate/core';

const localAxios = buildLocalAxios();
export const imageAlbumStore = createState({
  currentGalleryElement: null,
  galleryElements: null,
  modalOpened: false,
  modalUploadOpened: false,
});

export const FilesPendingContext = createContext([]);

export function fetchGalleryElements(imageAlbumId, startIndex, endIndex) {
  return localAxios.get(`/image_albums/${imageAlbumId}/gallery_elements`);
}
