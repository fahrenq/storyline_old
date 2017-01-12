$(document).on("turbolinks:load", () => {
  console.log('hi');
  $('#datetimepicker4').datetimepicker({
    format: 'DD-MM-YYYY HH:mm ZZ',
    defaultDate: new Date()
  });
});
