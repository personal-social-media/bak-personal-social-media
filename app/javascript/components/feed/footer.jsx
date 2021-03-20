import PostCommentsCount from './footer/comments-count';
import PostReactions from './footer/reactions';
import ReactionsCount from './footer/reactions-count';

export default function PostFooter({postState, post, peerInfo}) {
  return (
    <div className="mt-2">
      <div className="mx-10 flex justify-between items-center">
        <div className="pl-2">
          <ReactionsCount post={post}/>
        </div>
        <div>
          <PostCommentsCount post={post}/>
        </div>
      </div>
      <div>
        <div>
          <PostReactions postState={postState} post={post} peerInfo={peerInfo}/>
        </div>
      </div>
    </div>
  );
}
