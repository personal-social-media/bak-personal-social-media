import {formatUploadPercentage} from './format-upload-percentage';
import {localAxios} from '../http/build-axios';

export default class UploaderUpload {
  constructor(uploadPath, manager) {
    this.uploadPath = uploadPath;
    this.queueList = [];
    this.manager = manager;
  }

  start() {
    this.pooler = setInterval(() => {
      if (this.running) return;
      this._enqueue();
    }, 200);
  }

  stop() {
    return new Promise((resolve) => {
      const checkStopInterval = setInterval(() => {
        if (this.queueList.length > 0) return;
        clearInterval(this.pooler);
        clearInterval(checkStopInterval);
        resolve();
      }, 300);
    });
  }

  queue(files) {
    this.queueList.push(files);
    if (!this.running && this.queueList.length === 1) {
      this._enqueue();
    }
  }

  _enqueue() {
    this.running = true;
    const files = this.queueList.shift();
    if (!files || files.length < 1) return this.running = false;

    this.uploadFiles(files);
  }

  async uploadFiles(files) {
    const self = this;
    this.manager.updateState({
      currentUploadSize: files.reduce((accumulator, current) => accumulator + current.size, 0),
      statusMessage: `Uploading ${files.length} files...`,
      uploadPercentage: 0,
    });

    const formData = new FormData();
    files.forEach((f) => {
      formData.append(`uploaded_files[]`, f);
    });

    try {
      await localAxios({
        data: formData,
        headers: {'Content-Type': 'multipart/form-data'},
        method: 'post',
        onUploadProgress(progressEvent) {
          self.manager.updateState({
            uploadPercentage: formatUploadPercentage(progressEvent),
          });
        },
        url: this.uploadPath,
      });

      this.manager.updateFilesInState(files, {
        status: 'Uploaded',
      });

      this.removeFilesAfterUpload(files);
    } catch (e) {
      console.log(e);
    } finally {
      this.manager.updateState({
        currentUploadSize: null,
        statusMessage: 'Upload done',
        uploadPercentage: null,
      });
      this.running = false;
    }
  }

  removeFilesAfterUpload(files) {
    this.manager.availableFiles = this.manager.availableFiles.filter((f) => {
      return files.indexOf(f) === -1;
    });

    this.manager.updateState({
      availableFiles: this.manager.availableFiles,
    });
  }
}
