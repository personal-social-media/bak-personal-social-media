import {format as formatDate, intervalToDuration} from 'date-fns';

export default function VideoInformation({currentGalleryElement, download, destroy}) {
  const {id, element} = currentGalleryElement;
  const {realCreatedAt, realFileName, createdAt, durationSeconds} = element;
  let formattedDuration = '';
  if (durationSeconds) {
    const interval = intervalToDuration({end: durationSeconds * 1000, start: 0});
    formattedDuration = `${interval.hours}h:${interval.minutes}m:${interval.seconds}s`;
  }

  return (
    <div>
      <table className="pure-table text-sm h-32 mx-auto">
        <thead>
          <tr>
            <th>
            Id
            </th>
            <th>
            Name
            </th>
            <th>
            Duration
            </th>
            <th>
            Taken at
            </th>
            <th>
            Uploaded at
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>
              {id}
            </td>
            <td>
              {realFileName}
            </td>
            <td>
              {formattedDuration}
            </td>
            <td>
              {
              realCreatedAt ? formatDate(new Date(realCreatedAt), 'MMMM dd yyyy H:m') : '-'
              }
            </td>
            <td>
              {formatDate(new Date(createdAt), 'MMMM dd yyyy')}
            </td>
          </tr>
        </tbody>
      </table>

      <div style={{width: '30rem'}} className="mx-auto">
        <div className="flex justify-between mt-4">
          <button onClick={download} aria-label="Download">
            <i className="fa fa-download fa-3x text-gray-700 hover:text-gray-600"></i>
          </button>

          <button onClick={destroy} aria-label="Delete">
            <i className="fa fa-times fa-3x text-red-600 hover:text-gray-600"></i>
          </button>
        </div>
      </div>
    </div>
  );
}
