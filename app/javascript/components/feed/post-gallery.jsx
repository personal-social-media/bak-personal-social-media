import FeedItemPostGallerySingleImage from './post-gallery/single-image';

export default function FeedPostGallery({post}) {
  const {images, videos} = post;
  const imagesLength = images.length;
  const videosLength = videos.length;

  if (imagesLength === 0 && videosLength === 0) return null;
  if (imagesLength === 1 && videosLength === 0) {
    return (<div className="flex justify-center">
      <FeedItemPostGallerySingleImage images={images}/>
    </div>);
  }

  return null;
}
