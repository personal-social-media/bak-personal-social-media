import {useState} from '@hookstate/core';
import LikeReaction from './like-reaction';
import LoveReaction from './love-reaction';
import ReactionButton from './reactions-table/reaction-button';
import WowReaction from './wow-reaction';
let timeoutOpened;

const reactionContainerOptions = {className: 'h-12 w-12 flex justify-center items-center mx-2'};
const reactionImageOptions = {className: 'h-10 w-10 hover:h-12 hover:w-12', fill: 'white'};

export default function ReactionsTable({cacheReaction, children, childrenContainerOptions = {}, saveReaction, loading}) {
  const reactionsTable = useState({
    table: {
      opened: false,
    },
  });

  function openTable() {
    timeoutOpened = setTimeout(() => {
      reactionsTable.merge({
        table: {opened: true, waitingToBeOpened: false},
      });
    }, 900);
  }

  function closeTable() {
    clearTimeoutOpen();
    reactionsTable.merge({
      table: {opened: false},
    });
  }

  function clearTimeoutOpen() {
    clearTimeout(timeoutOpened);
  }

  return (
    <div onMouseEnter={openTable} onMouseLeave={clearTimeoutOpen}>
      {
        reactionsTable.table.opened.get() && <div className="absolute pb-12 bottom-0" onMouseLeave={closeTable}>
          <div className="bg-gray-700 z-10 p-1 flex justify-between items-center">
            <ReactionButton reactionType="like" saveReaction={saveReaction} loading={loading}>
              <LikeReaction cacheReaction={cacheReaction} imageOptions={reactionImageOptions} containerOptions={reactionContainerOptions}/>
            </ReactionButton>
            <ReactionButton reactionType="love" saveReaction={saveReaction} loading={loading}>
              <LoveReaction cacheReaction={cacheReaction} imageOptions={reactionImageOptions} containerOptions={reactionContainerOptions}/>
            </ReactionButton>
            <ReactionButton reactionType="wow" saveReaction={saveReaction} loading={loading}>
              <WowReaction cacheReaction={cacheReaction} imageOptions={reactionImageOptions} containerOptions={reactionContainerOptions}/>
            </ReactionButton>
          </div>
        </div>
      }

      <div {...childrenContainerOptions}>
        {children}
      </div>
    </div>
  );
}
