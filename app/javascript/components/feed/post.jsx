import {createState} from '@hookstate/core';
import {queueFeedFetchCacheReactions} from '../../lib/queue-events/feed-fetch-cache-reactions';
import {useEffect} from 'react';
import FeedPostGallery from './post-gallery';
import FeedPostPeerInfo from './post/peer-info';
import LikeReaction from '../../reactions/like-reaction';
import ReactionsTable from './reactions-table';

export default function FeedPost({data: post}) {
  const feedPostState = createState({
    cache: {
      reaction: null,
    },
  });
  const {content, peerInfo} = post;

  useEffect(() => {
    queueFeedFetchCacheReactions({item: post, state: feedPostState, type: 'post'});
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
        <ReactionsTable>
          <div className="ml-10">
            <LikeReaction imageOptions={{className: 'h-10 w-10 hover:h-12 hover:w-12'}} containerOptions={{className: 'h-12 w-12 flex justify-center items-center'}}/>
          </div>
        </ReactionsTable>
      </div>
    </div>
  );
}
