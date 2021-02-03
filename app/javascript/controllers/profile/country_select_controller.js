import {Controller} from 'stimulus';
import {buildLocalAxios} from '../../lib/http/build-axios';
import Suggestions from 'suggestions';
const axios = buildLocalAxios();

export default class extends Controller {
  static targets = ['cities'];

  connect() {
    this.typeahead = new Suggestions(this.citiesTarget, ['omg', 'lol'], {
      limit: 5,
      minLength: 1,
    });
  }

  async setCountry(e) {
    const {citiesTarget} = this;
    citiesTarget.value = '';
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
    citiesTarget.disabled = false;
    this.typeahead.data = cities;
    // const options = cities.map(c => {
    //   const el = document.createElement("option");
    //   el.value = c;
    //   el.textContent = c;
    // });

    // citiesTarget.append(...[options]);
  }
}
