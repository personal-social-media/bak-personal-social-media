export default function GalleryImageFile({galleryElement, state, cellHeight}) {
  const {element} = galleryElement;

  function open() {
    state.merge({
      currentGalleryElement: galleryElement,
      modalOpened: true,
    });
  }

  return (
    <div className="relative" onClick={open}>
      <img src={element.url} className="object-cover w-full cursor-pointer" style={{height: cellHeight}}/>
    </div>
  );
}
