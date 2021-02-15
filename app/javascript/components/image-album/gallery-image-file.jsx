export default function GalleryImageFile({galleryElement, realWidth, state}) {
  const {element} = galleryElement;
  const width = `${realWidth}px`;

  function open() {
    state.merge({
      currentGalleryElement: galleryElement,
      modalOpened: true,
    });
  }

  return (
    <div className="relative" style={{height: width, width: width}} onClick={open}>
      <img src={element.url} className="object-cover w-full h-full cursor-pointer"/>
    </div>
  );
}