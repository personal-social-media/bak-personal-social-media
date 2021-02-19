import {Controller} from 'stimulus';
import {feedBackError, feedbackSuccess} from '../../events/feedback';
import axios from 'axios';

export default class extends Controller {
  static targets = ['progress', 'submit'];

  async submit(e) {
    e.preventDefault();
    const form = e.target;
    this.submitTarget.disabled = true;
    const formData = new FormData(form);
    const progress = this.progressTarget;
    const count = progress.querySelector('.count');
    const counter = progress.querySelector('.counter');

    progress.classList.remove('hidden');

    try {
      await axios.post(form.action, formData, {
        onUploadProgress(progressEvent) {
          const percentCompleted = Math.round((progressEvent.loaded * 100) / progressEvent.total);
          count.style.width = `${percentCompleted}%`;
          counter.textContent = `${percentCompleted}%`;
          debugger;
        },
      });
    } catch (e) {
      return feedBackError('Unable to upload');
    } finally {
      this.submitTarget.disabled = false;
      progress.classList.add('hidden');
      count.style.width = '0%';
      counter.textContent= '';
    }

    if (this.element.dataset.after === 'reload') {
      window.Turbolinks.visit(window.location.toString(), {action: 'replace'});
    }

    feedbackSuccess('Saved');
  }
}
