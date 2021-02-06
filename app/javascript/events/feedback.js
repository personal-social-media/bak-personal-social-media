const toastr = window.toastr;

export function feedbackSuccess(message) {
  toastr.success(message);
}

export function feedBackError(message) {
  toastr.error(message);
}
