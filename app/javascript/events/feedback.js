const toastr = window.toastr;

export function feedbackSuccess(message) {
  toastr.success(message);
}

export function feedBackError(message) {
  toastr.error(message);
}

export function feedBackErrorLog(message) {
  if (process.env.RAILS_ENV === 'production') {
    return console.error(message);
  }
  return feedBackError(message);
}
