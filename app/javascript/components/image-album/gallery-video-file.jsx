export default function GalleryVideoFile({galleryElement, realWidth, state}) {
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
      <img src={element.screenshotUrl} className="object-cover w-full h-full cursor-pointer"/>
    </div>
  );
}
