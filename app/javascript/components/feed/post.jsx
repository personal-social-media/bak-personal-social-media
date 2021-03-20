import {queueFeedFetchCacheReactions} from '../../lib/queue-events/feed-fetch-cache-reactions';
import {saveReaction as saveReactionAction} from '../../lib/peer-to-peer-actions/reactions/save-reaction';
import {useEffect} from 'react';
import CurrentReaction from './reactions-table/current-reaction';
import FeedPostGallery from './post-gallery';
import FeedPostPeerInfo from './post/peer-info';
import ReactionsTable from './reactions-table';

const imageOptionsReaction = {className: 'h-10 w-10 hover:h-12 hover:w-12'};
const containerOptionsReaction = {className: 'h-14 w-14 flex justify-center items-center'};

export default function FeedPost({data: post}) {
  const content = post.content.get();
  const peerInfo = post.peerInfo.get();
  const uid = post.uid.get();
  const cacheReaction = post.cacheReaction.get();

  useEffect(() => {
    queueFeedFetchCacheReactions({item: post, type: 'post'});
  }, [post]); // eslint-disable-line react-hooks/exhaustive-deps

  async function saveReaction(reactionType) {
    const {id: peerId} = peerInfo;

    await saveReactionAction(cacheReaction, peerId, uid, 'post', reactionType, post);
  }

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
        <ReactionsTable cacheReaction={cacheReaction} childrenContainerOptions={{className: 'ml-10'}} saveReaction={saveReaction}>
          <CurrentReaction saveReaction={saveReaction} cacheReaction={cacheReaction} containerOptions={containerOptionsReaction} imageOptions={imageOptionsReaction}/>
        </ReactionsTable>
      </div>
    </div>
  );
}
