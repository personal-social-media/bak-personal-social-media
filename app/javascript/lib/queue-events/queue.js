export default class EventQueue {
  constructor(itemsLimit, runNowTimeout = 100, runFn) {
    this.cache = {};
    this.queue = [];
    this.itemsLimit = itemsLimit;
    this.runFn = runFn;
    this.runNowTimeout = runNowTimeout;
  }

  push(data) {
    if (this.cache[data.item.uid]) {
      return;
    }
    this.cache[data.item.uid] = '_PLACEHOLDER_';

    this.queue.push(data);
  }

  async run() {
    const currentItems = this.queue.splice(0, this.itemsLimit);

    await this.runFn(currentItems);
    if (this.queue.length < 1) {
      this.running = false;
      return;
    }
    this.run();
  }

  runNow() {
    if (this.running || this.queue.length < 1) {
      return;
    }
    this.running = true;

    setTimeout(() => {
      this.run();
    }, this.runNowTimeout);
  }
}
