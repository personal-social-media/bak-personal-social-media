export default function FocusedModalPicture({currentGalleryElement}) {
  const {element} = currentGalleryElement;

  return (
    <div>
      <img src={element.originalUrl} className="w-full rounded"/>
    </div>
  );
}
