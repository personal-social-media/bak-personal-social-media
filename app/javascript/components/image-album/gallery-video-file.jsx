import {useState} from 'react';
import imageVideo from '../../images/actions/play-button.svg';

export default function GalleryVideoFile({galleryElement, state, imageHeight}) {
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
          <video src={element.shortUrl} className="w-full object-cover object-center cursor-pointer" autoPlay loop style={{height: imageHeight}}>

          </video> :
          <div>
            <img src={element.screenshotUrl} className="object-cover object-center w-full cursor-pointer" style={{height: imageHeight}}/>
            <img src={imageVideo} className="absolute h-10 w-10" style={{bottom: '2px', left: '2px'}}/>
          </div>
      }
    </div>
  );
}
