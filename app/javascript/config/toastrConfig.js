import toastr from 'toastr';

window.toastr = toastr;

toastr.options({
  closeButton: true,
  progressBar: true,
  positionClass: 'toast-bottom-right'
});

export default toastr;
