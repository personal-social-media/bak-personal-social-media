import {Controller} from 'stimulus';
import EventBus from 'eventing-bus';

export default class extends Controller {
  static targets = ['content', 'background'];
  opened = false;

  connect() {
    this.subscribeForceClose();
  }

  toggle() {
    this.opened = !this.opened;
    this.backgroundTarget.classList.toggle('inset-0');
    this.backgroundTarget.classList.toggle('hidden');
    this.contentTarget.classList.toggle('inset-0');
    this.contentTarget.classList.toggle('hidden');
    document.body.classList.toggle('overflow-y-hidden');
  }

  close(e) {
    if (!e.target.matches('.modal-container')) {
      return;
    }

    this.toggle();
  }

  forceClose(e) {
    e?.preventDefault();

    this.toggle();
  }

  subscribeForceClose() {
    EventBus.on('MODAL/CLOSE', () => {
      if (this.opened) {
        this.forceClose();
      }
    });
  }
}
