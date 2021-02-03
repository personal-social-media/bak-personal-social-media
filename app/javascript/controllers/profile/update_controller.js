import {Controller} from 'stimulus';

export default class extends Controller {
  static targets = ['image', 'imageFile'];

  change() {
    this.imageFileTarget.addEventListener('change', (e) => {
      this.imageTarget.src = URL.createObjectURL(e.target.files[0]);
    }, {once: true});
    this.imageFileTarget.click();
  }
}
