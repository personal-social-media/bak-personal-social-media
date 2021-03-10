import FeedPostGallery from './post-gallery';
import FeedPostPeerInfo from './post/peer-info';

export default function FeedPost({data: post}) {
  const {content, peerInfo} = post;

  return (
    <div className="bg-gray-400 text-white rounded-lg shadow overflow-hidden">
      <div className="px-2 py-3">
        <div>
          <FeedPostPeerInfo peerInfo={peerInfo} post={post}/>
        </div>
        <div>
          {content}
        </div>
      </div>

      <FeedPostGallery post={post}/>
    </div>
  );
}
