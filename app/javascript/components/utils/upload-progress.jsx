import prettyBytes from 'pretty-bytes';

export function UtilsUploadProgress({uploadPercentage, currentUploadSize}) {
  const alreadyUploaded = (uploadPercentage / 100) * currentUploadSize;
  const width = `${uploadPercentage}%`;

  return (
    <div className="upload-progress relative pt-3">
      <div className="overflow-hidden mb-4 text-xs flex rounded bg-green-200">
        <div style={{width: width}} className="count shadow-none flex flex-col text-center whitespace-nowrap justify-center bg-green-500 absolute inset-0">
        </div>
        <div className="counter text-center py-2 text-white w-full z-10 font-bold flex flex-col justify-center">
          <div>
            {width}
          </div>
          <div>
            {prettyBytes(alreadyUploaded)} / {prettyBytes(currentUploadSize)}
          </div>
        </div>
      </div>
    </div>
  );
}
