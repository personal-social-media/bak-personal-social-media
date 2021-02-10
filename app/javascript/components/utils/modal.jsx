import {createState, useState} from '@hookstate/core';
import {useEffect, useRef} from 'react';

const defaultState = {
  background: {
    className: 'hidden bg-gray-600 fixed opacity-50',
  },
  content: {
    className: 'hidden fixed modal-container overflow-y-scroll pb-32',
  },
};
const _state = createState({...defaultState});
export default function Modal({setOpened, opened, children}) {
  const state = useState(_state);
  const containerRef = useRef();

  useEffect(() => {
    if (!opened) {
      return state.merge(defaultState);
    }
    state.merge((s) => {
      return {
        background: {
          className: s.background.className.replace('hidden ', '') + ' inset-0',
        },
        content: {
          className: s.content.className.replace('hidden ', '') + ' inset-0',
        },
      };
    });
  }, [opened]); // eslint-disable-line react-hooks/exhaustive-deps

  function close(e) {
    if (!opened) return;
    const {current} = containerRef;
    if (current !== e.target) return;
    setOpened(false);
  }

  return (
    <div>
      <div className={state.content.className.get()} style={{zIndex: 1001}} onClick={close} ref={containerRef}>
        <div className="mx-auto mt-32 w-1/3 bg-white shadow-xl rounded border border-solid border-gray-200 p-4">
          {children}
        </div>
      </div>

      <div className={state.background.className.get()} style={{zIndex: 1000}}/>
    </div>
  );
}
