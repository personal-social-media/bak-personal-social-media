import FeedPostPeerInfo from './post/peer-info';

export default function FeedPost({data: post}) {
  const {content, peerInfo} = post;

  return (
    <div className="bg-gray-400 px-2 py-3 text-white rounded-lg shadow">
      <div>
        <FeedPostPeerInfo peerInfo={peerInfo} post={post}/>
      </div>
      <div>
        {content}
      </div>
    </div>
  );
}
