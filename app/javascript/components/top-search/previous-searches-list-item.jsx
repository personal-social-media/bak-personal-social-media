import {feedBackError} from '../../events/feedback';
import {removeFromSearch} from '../../lib/peer-to-peer-actions/search/remove-search';
import UserAvatar from '../user/avatar';

export default function PreviousSearchListItem({search, state}) {
  const {peerInfo} = search;

  async function remove(e) {
    e.preventDefault();
    e.stopPropagation();

    try {
      await removeFromSearch(search);
    } catch {
      return feedBackError('Unable to remove from search');
    }

    state.merge((s) => {
      return {
        previousSearches: s.previousSearches.filter((s) => s.id !== search.id),
      };
    });
  }

  return (
    <a href={`/u/${peerInfo.id}`} className="no-underline cursor-default">
      <div className="flex items-center">
        <UserAvatar username={peerInfo.username} avatars={peerInfo.avatars}
          imageOptions={{className: 'h-10 w-10 rounded-full object-cover object-center cursor-pointer'}}
        />

        <div className="ml-1 text-gray-700 text-lg cursor-pointer">
          {peerInfo.name}
        </div>

        <div className="w-full text-right">
          <span className="text-gray-700 hover:text-gray-800 text-xs cursor-pointer" onClick={remove}>
            X
          </span>
        </div>
      </div>
    </a>
  );
}
