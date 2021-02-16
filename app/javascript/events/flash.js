import {feedBackError, feedbackSuccess} from './feedback';
import domReady from './dom-ready';

domReady(() => {
  const notice = document.querySelector('meta[name=\'flash-notice\']');
  if (!notice) return;

  feedbackSuccess(notice.content);
});

domReady(() => {
  const error = document.querySelector('meta[name=\'flash-error\']');
  if (!error) return;

  feedBackError(error.content);
});
