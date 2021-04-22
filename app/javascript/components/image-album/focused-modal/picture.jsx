import {getProperties} from '../../../lib/utils/get-properties';

export default function FocusedModalPicture({currentGalleryElement}) {
  const {originalUrl} = getProperties(currentGalleryElement.element, 'originalUrl');

  return (
    <div>
      <img src={originalUrl} className="object-cover object-center mx-auto rounded" style={{maxHeight: '60vh'}}/>
    </div>
  );
}
