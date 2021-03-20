import {queueFeedFetchCacheReactions} from '../../lib/queue-events/feed-fetch-cache-reactions';
import {useEffect} from 'react';
import {useState} from '@hookstate/core';
import FeedPostGallery from './post-gallery';
import FeedPostPeerInfo from './post/peer-info';
import PostFooter from './footer';

export default function FeedPost({data: post}) {
  const postState = useState({
    reactionActionLoading: false,
  });
  const content = post.content.get();
  const peerInfo = post.peerInfo.get();

  useEffect(() => {
    queueFeedFetchCacheReactions({item: post, type: 'post'});
  }, [post]); // eslint-disable-line react-hooks/exhaustive-deps

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

      <div className="mx-2">
        <PostFooter peerInfo={peerInfo} post={post} postState={postState}/>
      </div>
    </div>
  );
}
