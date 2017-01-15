$(document).on('turbolinks:load', () => {
  $('.ui.dropdown.user-nav').dropdown();

  $('#sidebar-opener').on('click', () => {
    $('.ui.sidebar').sidebar('toggle');
  });
});
