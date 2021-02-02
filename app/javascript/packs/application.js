import '../stylesheets/main.scss';
import '../stylesheets/tailwind.css';

import {Application} from 'stimulus';
import {definitionsFromContext} from 'stimulus/webpack-helpers';

const application = Application.start();
const context = require.context('../controllers', true, /\.js$/);
application.load(definitionsFromContext(context));

if (process.env.RAILS_ENV !== 'production') {
  console.log(definitionsFromContext(context).map((el) => el.identifier));
}


const ReactRailsUJS = require('react_ujs');
const componentRequireContext = require.context('components', true);
ReactRailsUJS.useContext(componentRequireContext); // eslint-disable-line react-hooks/rules-of-hooks