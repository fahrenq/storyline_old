$(document).on("turbolinks:load", () => {
  $('#datetimepicker4').datetimepicker({
    format: 'DD-MM-YYYY HH:mm ZZ',
    // defaultDate: new Date(), not needed since we have maxDate set
    maxDate: new Date(),
    collapse: false
  });
});
