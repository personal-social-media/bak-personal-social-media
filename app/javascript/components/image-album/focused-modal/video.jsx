export default function FocusedModalVideo({currentGalleryElement}) {
  const {element} = currentGalleryElement;

  return (
    <div>
      <video src={element.originalUrl} className="w-full rounded" controls>

      </video>
    </div>
  );
}
