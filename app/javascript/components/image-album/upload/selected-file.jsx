const imageRegex = /(image\/*)/;
const videoRegex = /(video\/*)/;

export default function SelectedFile({data: pendingFile, uploadManager}) {
  const {name, localUrl, type, alreadyUploaded, status, removed} = pendingFile;

  function _remove(e) {
    e.preventDefault();
    uploadManager.removeFile(pendingFile);
  }
  const containerExtraStyles = {
    filter: alreadyUploaded ? 'grayscale(80%)' : '',
    height: '140px',
  };

  return (
    <div className="overflow-hidden" style={containerExtraStyles}>
      {
        !removed && <div>
          {
            imageRegex.test(type) &&
            <img src={localUrl} alt={name} className="object-cover w-full" style={{height: '100px'}}/>
          }

          {
            videoRegex.test(type) &&
            <video src={localUrl} controls className="object-cover w-full" style={{height: '100px'}}>

            </video>
          }

          <div className="text-sm bottom-0 z-10 text-center">
            {
              status ?
                <div className="text-xs">
                  {status}
                </div> :
                <button aria-label="Remove" onClick={_remove}>
                  <i className="fa fa-remove fa-2x text-red-600 hover:text-red-500"/>
                </button>
            }
          </div>
        </div>
      }
    </div>
  );
}
