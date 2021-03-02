import {FilesPendingContext} from '../store';
import {UploaderManager} from '../../../lib/uploader/manager';
import {UtilsUploadProgress} from '../../utils/upload-progress';
import {uniqBy} from 'lodash';
import {useContext, useRef} from 'react';

const selectRegex = /(image\/*|video\/*)/;

export default function UploadFileSelector({imageAlbumId}) {
  const inputRef = useRef();
  const [pendingFiles, setPendingFiles] = useContext(FilesPendingContext);
  const {files, uploadManager, status, statusMessage, uploadPercentage, currentUploadSize} = pendingFiles;

  function fileSelected(e) {
    let newFiles = Array.from(e.target.files).filter((f) => {
      return f.type.match(selectRegex);
    });
    newFiles.forEach((f) => {
      f.localUrl = URL.createObjectURL(f);
    });
    newFiles = uniqBy([...newFiles, ...files], 'name');

    const newState = {
      ...pendingFiles,
      availableFiles: newFiles,
      files: newFiles,
    };

    newState.uploadManager = new UploaderManager({
      selectRegex,
      setState: setPendingFiles,
      state: newState,
      uploadPath: `/image_albums/${imageAlbumId}/gallery_elements/upload`,
    });

    setPendingFiles(newState);
  }

  function startUpload(e) {
    e.preventDefault();
    uploadManager.upload();
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

      {
        files.length > 0 && !status && <div className="text-left">
          <button className="pure-button pure-button-primary" onClick={startUpload}>
            Start upload
          </button>
        </div>
      }

      {
        status === 'uploading' && <div className="mt-2">
          {statusMessage}
        </div>
      }

      {
        uploadPercentage && currentUploadSize &&
          <div className="my-1">
            <h3>ok</h3>
            <UtilsUploadProgress currentUploadSize={currentUploadSize} uploadPercentage={uploadPercentage}/>
          </div>
      }
    </div>
  );
}
