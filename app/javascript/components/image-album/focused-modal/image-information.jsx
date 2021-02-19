import {format as formatDate} from 'date-fns';

export default function ImageInformation({currentGalleryElement, download, destroy}) {
  const {element} = currentGalleryElement;
  const {realCreatedAt, realFileName, createdAt} = element;

  return (
    <div style={{width: '30rem'}} className="mx-auto">
      <table className="pure-table text-sm h-32">
        <thead>
          <tr>
            <th>
              Name
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
              {realFileName}
            </td>
            <td>
              {formatDate(new Date(realCreatedAt), 'MMMM dd yyyy H:m')}
            </td>
            <td>
              {formatDate(new Date(createdAt), 'MMMM dd yyyy')}
            </td>
          </tr>
        </tbody>
      </table>

      <div className="flex justify-between mt-4">
        <button onClick={download} aria-label="Download">
          <i className="fa fa-download fa-3x text-gray-700 hover:text-gray-600"></i>
        </button>

        <button onClick={destroy} aria-label="Delete">
          <i className="fa fa-times fa-3x text-red-600 hover:text-gray-600"></i>
        </button>
      </div>
    </div>
  );
}
