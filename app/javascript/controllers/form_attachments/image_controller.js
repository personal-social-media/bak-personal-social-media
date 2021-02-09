import {Controller} from 'stimulus';
import {feedbackSuccess} from '../../events/feedback';
import {uniqBy} from 'lodash';
import EventBus from 'eventing-bus';

export default class extends Controller {
  images = [];
  imagesCount = 0;

  connect() {
    this.watchSubmit();
  }

  addImage() {
    const input = document.createElement('input');
    input.type = 'file';
    input.style.display = 'none';
    input.accept = 'image/*,video/*';
    input.multiple = true;
    input.name = `image_${this.imagesCount += 1}`;
    this.element.appendChild(input);
    input.click();
    input.addEventListener('change', (e) => {
      this.handleNewFiles([...e.target.files]);
      input.remove();
    });
  }

  handleNewFiles(files) {
    this.images = uniqBy([...files, ...this.images], (el) => el.name);
    const container = document.querySelector(`#${this.element.dataset.imagesContainer}`);
    const imageEls = this.images.map((image) => {
      const el = document.createElement('div');
      el.innerHTML = `
        <div>
          <img />
          <div class="text-center mt-2">
            <a>Remove</a>
          </div>
        </div>
      `;
      const imgEl = el.querySelector('img');
      const a = el.querySelector('a');
      imgEl.src = URL.createObjectURL(image);
      imgEl.className = 'rounded shadow-xl object-cover';
      imgEl.style.height = '10rem';
      imgEl.style.width = '10rem';

      a.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopPropagation();
        this.images = this.images.filter((img) => img !== image);
        this.handleNewFiles([]);
      });
      return el;
    });

    container.innerHTML = '';
    imageEls.forEach((el) => container.appendChild(el));
  }

  watchSubmit() {
    const form = document.querySelector(`#${this.element.dataset.submitButton}`);
    const submit = form.querySelector('button[type=\'submit\']');

    form.addEventListener('submit', async (e) => {
      e.preventDefault();

      const formData = new FormData(form);

      this.images.forEach((image, i) => {
        formData.append('post[files][]', image);
      });
      submit.disabled = true;
      submit.textContent = 'Saving...';

      try {
        fetch(form.action, {body: formData, method: 'POST'});
      } catch (e) {
        console.log(e);
      } finally {
        submit.disabled = false;
      }

      this.saved(form, submit);
    });
  }

  saved(form, submit) {
    submit.textContent = submit.dataset.initialText;
    this.images = [];
    this.handleNewFiles([]);

    EventBus.publish('MODAL/CLOSE');
    feedbackSuccess('Post created');
    form.reset();
  }
}
