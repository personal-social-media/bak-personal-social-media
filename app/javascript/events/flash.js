import {feedbackSuccess} from '../../snowpacker/events/feedback';
import domReady from './dom-ready';

domReady(() => {
  const notice = document.querySelector('meta[name=\'flash-notice\']');
  console.log(notice);
  if (!notice) return;

  feedbackSuccess(notice.content);
});
