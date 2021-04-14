import {Controller} from 'stimulus';
import {deviceType} from '../../lib/device/device-type';
import {localAxios} from '../../lib/http/build-axios';

export default class extends Controller {
  static targets = ['footer', 'content', 'sidebar', 'openButton', 'navbar', 'navbarContent'];

  async connect() {
    this.open = this.element.dataset.settingsOpened === 'true';
  }

  async toggleOpen(e) {
    e.preventDefault();

    if (this.open) {
      this.close();
    } else {
      this.openSidebar();
    }
    if (deviceType === 'mobile') return;
    await this.syncChanges(this.open);
  }

  close() {
    this.open = false;
    this.sidebarTarget.classList.add('hidden');
    this.contentTarget.classList.remove('ml-64');
    this.footerTarget.classList.remove('ml-64');
    this.navbarTarget.classList.add('left-0');
    this.navbarContentTarget.classList.add('ml-4');
    this.openButtonTarget.classList.remove('hidden');
  }

  openSidebar() {
    this.open = true;
    this.sidebarTarget.classList.remove('hidden');
    this.contentTarget.classList.add('ml-64');
    this.footerTarget.classList.add('ml-64');
    this.navbarTarget.classList.remove('left-0');
    this.navbarContentTarget.classList.remove('ml-4');
    this.openButtonTarget.classList.add('hidden');
  }

  syncChanges(uiSidebarOpened) {
    return localAxios.patch('/setting', {setting: {uiSidebarOpened}});
  }
}
