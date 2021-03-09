import {format as formatDate} from 'timeago.js';
import {useState} from '@hookstate/core';
import useInterval from 'use-interval';

export default function UtilsDateTooltip({date, className}) {
  const realDate = new Date(date);
  const state = useState({
    formattedDateAgo: formatDate(realDate),
    opened: false,
  });

  useInterval(() => {
    state.merge({
      formattedDateAgo: formatDate(realDate),
    });
  }, 15_000);

  return (
    <div className="relative">
      <div className={className}
        onMouseEnter={() => state.merge({opened: true})}
        onMouseLeave={() => state.merge({opened: false})}
      >
        {
          state.formattedDateAgo.get()
        }
      </div>

      {
        state.opened.get() && <div className="absolute px-2 py-1 bg-gray-100 text-gray-700 text-xs rounded shadow opacity-75">
          {date}
        </div>
      }
    </div>
  );
}
