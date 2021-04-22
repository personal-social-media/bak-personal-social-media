import {getProperties} from '../../lib/utils/get-properties';

export default function GalleryImageFile({galleryElement, state, imageHeight}) {
  const {url} = getProperties(galleryElement.element, 'url');

  function open() {
    state.merge({
      currentGalleryElement: galleryElement.get(),
      modalOpened: true,
    });
  }

  return (
    <div className="relative" onClick={open}>
      <img src={url} className="object-cover object-center w-full cursor-pointer" style={{height: imageHeight}}/>
    </div>
  );
}
