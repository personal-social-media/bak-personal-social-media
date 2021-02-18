import {Controller} from 'stimulus';
import {feedBackError} from "../../events/feedback";

export default class extends Controller {
  static targets = ['image', 'imageFile', 'video'];

  connect(){
    this.showDefault();
  }

  change() {
    this.imageFileTarget.addEventListener('change', (e) => {
      const file = e.target.files[0];
      if(/video/i.test(file.type)){
        return this.handleVideo(file)
      }else if(/image/i.test(file.type)){
        return this.handleImage(file);
      }else{
        feedBackError("Only images and videos are supported");
      }
    }, {once: true});
    this.imageFileTarget.click();
  }

  handleVideo(video){
    const { videoTarget, imageTarget } = this;

    imageTarget.classList.add("hidden");
    videoTarget.classList.remove("hidden");
    videoTarget.src = URL.createObjectURL(video);
  }

  handleImage(image){
    const { videoTarget, imageTarget } = this;

    videoTarget.classList.add("hidden");
    imageTarget.classList.remove("hidden");
    imageTarget.src = URL.createObjectURL(image);
  }

  showDefault(){
    const { videoTarget, imageTarget } = this;
    const videoSource = videoTarget.querySelector("source");
    if(videoSource.src !== location.href){
      return videoTarget.classList.remove("hidden")
    }
    return imageTarget.classList.remove("hidden")
  }
}
