import {FilesPendingContext} from '../store';
import {uniqBy} from 'lodash';
import {useContext} from 'react';
import {useRef} from 'react';
const selectRegex = /(image\/*|video\/*)/;

export default function UploadFileSelector() {
  const inputRef = useRef();
  const [pendingFilesForUpload, setPendingFilesForUpload] = useContext(FilesPendingContext);

  function fileSelected(e) {
    const files = Array.from(e.target.files).filter((f) => {
      return f.type.match(selectRegex);
    });
    setPendingFilesForUpload(
        uniqBy([...files, ...pendingFilesForUpload], 'name'),
    );
  }

  function selectFiles(e) {
    e.preventDefault();
    inputRef.current.click();
  }

  return (
    <div>
      <button className="pure-button" onClick={selectFiles}>
        Select files
      </button>

      <input type="file" className="hidden" ref={inputRef} onChange={fileSelected} accept="image/*,video/*" multiple={true}/>
    </div>
  );
}
