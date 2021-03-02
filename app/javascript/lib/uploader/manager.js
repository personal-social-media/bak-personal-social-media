import {chunk} from 'lodash';
import UploaderUpload from './upload';
import md5Calculator from 'md5-webworker';

export class UploaderManager {
  constructor({state, setState, selectRegex, uploadPath}) {
    this.state = state;
    this.setState = setState;
    this.files = state.files;
    this.availableFiles = state.availableFiles;
    this.alreadySavedMd5CheckSums = state.alreadySavedMd5CheckSums;
    this.selectRegex = selectRegex;
    this.uploader = new UploaderUpload(uploadPath, this);
  }

  totalSize() {
    return this.availableFiles.reduce((accumulator, current) => accumulator + current.size, 0);
  }

  removeFile(file) {
    this.availableFiles = this.availableFiles.filter((f) => {
      return f !== file;
    });

    this.updateState({
      availableFiles: this.availableFiles,
    });

    this.updateFilesInState([file], {removed: true});
  }

  async upload(chunkFiles = null) {
    if (!chunkFiles) {
      this.updateState({status: 'uploading', statusMessage: 'Calculating MD5 for files...'});
      this.updateFilesInState(this.availableFiles, {status: 'Preparing'});
      this.uploader.start();
      chunkFiles = chunk(this.availableFiles, 10);
    }
    if (chunkFiles.length < 1) {
      return this.uploader.stop().then(() => {
        window.Turbolinks.reload;
      });
    }

    const duppedFiles = [];
    const files = chunkFiles.shift(0);

    await this.calculateMd5s(files);
    const dedupedFiles = files.filter((f) => {
      const result = f.md5 && this.alreadySavedMd5CheckSums.indexOf(f.md5) === -1;
      if (!result) {
        duppedFiles.push(f);
        return false;
      }
      return f;
    });

    this.updateFilesInState(duppedFiles, {
      alreadyUploaded: true,
      status: 'Already saved',
    });

    this.uploader.queue(dedupedFiles);

    return this.upload(chunkFiles);
  }

  calculateMd5s(files) {
    const promises = files.map((file) => {
      return new Promise(async (resolve) => {
        this.setFileStatus(file, 'Calculating MD5');
        try {
          file.md5 = await md5Calculator(file);
          this.setFileStatus(file, 'MD5 ready');
          return resolve(file);
        } catch {
          this.setFileStatus(file, 'MD5 Failed');
          return resolve(file);
        }
      });
    });

    return Promise.all(promises);
  }

  updateFilesInState(files, update) {
    this.updateState({
      files: this.files.map((f) => {
        if (files.indexOf(f) === -1) return f;
        Object.assign(f, update);
        return f;
      }),
    });
  }

  setFileStatus(file, status) {
    this.updateFilesInState([file], {status: status});
  }

  updateState(change) {
    Object.assign(this.state, change);

    this.setState({
      ...this.state,
    });
  }
}
