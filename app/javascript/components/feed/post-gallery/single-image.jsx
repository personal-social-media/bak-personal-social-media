import mergeStyles from '../../../lib/utils/string/merge-styles';

export default function FeedItemPostGallerySingleImage({images}) {
  const image = images[0];
  const {size: imageSize, url} = image;
  const {width, height} = imageSize;

  let size = 'square'; let containerSize; let objectFit;
  if (width > height) size = 'landscape';
  if (height > width) size = 'portrait';

  switch (size) {
    case 'landscape':
      containerSize = {height: '45rem', width: '100%'};
      objectFit = 'object-cover';
      break;
    case 'portrait':
      containerSize = {height: '65rem', width: '30rem'};
      objectFit = 'object-cover';
      break;
    default:
      objectFit = 'object-fill';
      containerSize = {height: '45rem', width: '45rem'};
  }

  return (
    <div style={containerSize}>
      <img src={url} alt="single image" className={mergeStyles('h-full w-full', objectFit)}/>
    </div>
  );
}
