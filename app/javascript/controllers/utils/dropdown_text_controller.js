import {Controller} from 'stimulus';

export default class extends Controller {
  toggleShow() {
    this.element.classList.toggle('overflow-y-hidden');
    this.element.classList.toggle(this.element.dataset.height);
  }
}
