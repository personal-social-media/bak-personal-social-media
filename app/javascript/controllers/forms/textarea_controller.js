import {Controller} from 'stimulus';

export default class extends Controller {
  connect() {
    this.element.addEventListener('input', this.expand.bind(this));
    this.expand();
  }

  expand() {
    this.element.style.height = 'auto';
    this.element.style.height = (this.element.scrollHeight)+'px';
  }
}
