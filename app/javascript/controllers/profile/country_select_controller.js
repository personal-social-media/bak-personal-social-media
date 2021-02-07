import {Controller} from 'stimulus';
import {buildLocalAxios} from '../../lib/http/build-axios';
import Suggestions from 'suggestions';
const axios = buildLocalAxios();

export default class extends Controller {
  static targets = ['city', 'country'];

  connect() {
    this.typeahead = new Suggestions(this.cityTarget, ['omg', 'lol'], {
      limit: 5,
      minLength: 1,
    });

    this.disableCityDefault();
  }

  async setCountry(e) {
    const {cityTarget} = this;
    cityTarget.value = '';
    const country = e.target.value;
    e.target.disabled = true;
    let response;
    try {
      response = await axios.get(`/cities?q=${country}`);
    } finally {
      e.target.disabled = false;
    }
    if (!response) return;

    const {cities} = response.data;
    cityTarget.disabled = false;
    this.typeahead.data = cities;
  }

  disableCityDefault() {
    if (this.countryTarget.value) return;

    this.cityTarget.disabled = true;
  }
}
