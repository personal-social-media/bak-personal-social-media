import {createState, useState} from '@hookstate/core';
import {useEffect, useRef} from 'react';
import {useHotkeys} from 'react-hotkeys-hook';

const defaultState = {
  background: {
    className: 'hidden bg-gray-600 fixed opacity-50',
  },
  content: {
    className: 'hidden fixed modal-container overflow-y-scroll pb-32',
  },
};
export default function Modal({setOpened, opened, modalStyle = {}, children}) {
  const _state = useRef(createState({...defaultState}));
  const state = useState(_state.current);
  const containerRef = useRef();

  useHotkeys('escape', () => {
    if (!opened) setOpened(false);
  });

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
        <div className="mx-auto mt-32 md:w-1/2 w-full bg-white shadow-xl rounded border border-solid border-gray-200 p-4" style={modalStyle}>
          {children}
        </div>
      </div>

      <div className={state.background.className.get()} style={{zIndex: 1000}}/>
    </div>
  );
}
