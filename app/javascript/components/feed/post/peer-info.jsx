import UserAvatar from '../../user/avatar';
import UserLink from '../../user/link';
import UtilsDateTooltip from '../../utils/date/tooltip';

export default function FeedPostPeerInfo({peerInfo, post}) {
  const {avatars, username} = peerInfo;
  const {createdAt: createdAtPost} = post;

  return (
    <div className="flex items-center">
      <UserLink peerInfo={peerInfo}>
        <UserAvatar avatars={avatars} username={username} imageOptions={{className: 'h-8 w-8 rounded-full object-cover'}}/>
      </UserLink>
      <div className="ml-2">
        <div>
          <UserLink peerInfo={peerInfo}>
            {username}
          </UserLink>
        </div>

        <div>
          <UtilsDateTooltip date={createdAtPost} className="text-xs hover:underline"/>
        </div>
      </div>
    </div>
  );
}
