export default class EventQueue {
  constructor(itemsLimit, runNowTimeout = 100, runFn) {
    this.queue = [];
    this.itemsLimit = itemsLimit;
    this.runFn = runFn;
    this.runNowTimeout = runNowTimeout;
  }

  push(data) {
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
