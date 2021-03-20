import {saveReaction as saveReactionAction} from '../../../lib/peer-to-peer-actions/reactions/save-reaction';
import CurrentReaction from '../../reactions/reactions-table/current-reaction';
import ReactionsTable from '../../reactions/reactions-table';

const imageOptionsReaction = {className: 'h-10 w-10 hover:h-12 hover:w-12'};
export default function PostReactions({postState, post, peerInfo}) {
  const cacheReaction = post.cacheReaction.get();
  const uid = post.uid.get();

  async function saveReaction(reactionType) {
    const {id: peerId} = peerInfo;
    postState.merge({
      reactionActionLoading: true,
    });
    await saveReactionAction(cacheReaction, peerId, uid, 'post', reactionType, post);
    postState.merge({
      reactionActionLoading: false,
    });
  }

  return (
    <div>
      <ReactionsTable cacheReaction={cacheReaction} childrenContainerOptions={{className: 'ml-10'}} saveReaction={saveReaction} loading={postState.reactionActionLoading.get()}>
        <div className="h-14 w-14 flex justify-center items-center">
          <CurrentReaction saveReaction={saveReaction} cacheReaction={cacheReaction} imageOptions={imageOptionsReaction} loading={postState.reactionActionLoading.get()}/>
        </div>
      </ReactionsTable>
    </div>
  );
}
