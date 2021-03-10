export default function FocusedModalPicture({currentGalleryElement}) {
  const {element} = currentGalleryElement;

  return (
    <div>
      <img src={element.originalUrl} className="object-cover object-center mx-auto rounded" style={{maxHeight: '60vh'}}/>
    </div>
  );
}
