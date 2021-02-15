import {feedbackSuccess} from './feedback';
import domReady from './dom-ready';

domReady(() => {
  const notice = document.querySelector('meta[name=\'flash-notice\']');
  if (!notice) return;

  feedbackSuccess(notice.content);
});
