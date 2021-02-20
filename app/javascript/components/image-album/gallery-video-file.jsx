import {useState} from 'react';
import imageVideo from '../../images/actions/play-button.svg';

export default function GalleryVideoFile({galleryElement, state, cellHeight}) {
  const {element} = galleryElement;
  const [localState, setLocalState] = useState({
    showVideo: false,
  });

  function toggleVideo(value) {
    setLocalState({
      ...localState,
      showVideo: value,
    });
  }

  function open() {
    state.merge({
      currentGalleryElement: galleryElement,
      modalOpened: true,
    });
  }

  return (
    <div className="relative" onClick={open}
      onMouseEnter={() => toggleVideo(true)}
      onMouseLeave={() => toggleVideo(false)}
    >
      {
        localState.showVideo ?
          <video src={element.shortUrl} className="w-full object-cover cursor-pointer" autoPlay loop style={{height: cellHeight}}>

          </video> :
          <div>
            <img src={element.screenshotUrl} className="object-cover w-full cursor-pointer" style={{height: cellHeight}}/>
            <img src={imageVideo} className="absolute h-10 w-10" style={{bottom: '2px', left: '2px'}}/>
          </div>
      }
    </div>
  );
}
