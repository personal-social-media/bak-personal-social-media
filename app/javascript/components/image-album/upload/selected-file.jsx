export default function SelectedFile({pendingFile, realWidth, remove}) {
  const width = `${realWidth}px`;
  const {name} = pendingFile;
  const src = URL.createObjectURL(pendingFile);

  function _remove(e) {
    e.preventDefault();
    remove(pendingFile);
  }

  return (
    <div className="relative" style={{height: width, width: width}}>
      <img src={src} alt={name} className="object-cover w-full h-full"/>

      <div className="text-sm absolute bottom-0 z-10">
        <button aria-label="Remove" onClick={_remove}>
          <i className="fa fa-remove fa-2x text-red-600 hover:text-red-500"></i>
        </button>
      </div>
    </div>
  );
}
