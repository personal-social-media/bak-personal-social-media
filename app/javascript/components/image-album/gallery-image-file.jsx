export default function GalleryImageFile({galleryElement, state, imageHeight}) {
  const {element} = galleryElement;

  function open() {
    state.merge({
      currentGalleryElement: galleryElement,
      modalOpened: true,
    });
  }

  return (
    <div className="relative" onClick={open}>
      <img src={element.url} className="object-cover w-full cursor-pointer" style={{height: imageHeight}}/>
    </div>
  );
}
