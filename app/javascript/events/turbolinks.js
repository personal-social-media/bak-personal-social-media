import domReady from './dom-ready';

let scrollPosition;
domReady(() => {
  if (scrollPosition) {
    window.scrollTo.apply(window, scrollPosition); // eslint-disable-line prefer-spread
    scrollPosition = null;
  }
});

window.Turbolinks.reload = () => {
  scrollPosition = [window.scrollX, window.scrollY];
  window.Turbolinks.visit(window.location, {action: 'replace'});
};
