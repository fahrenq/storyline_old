$(document).on('turbolinks:load', () => {
  $('.ui.dropdown.user-nav').dropdown();

  $('#sidebar-opener').on('click', () => {
    $('.ui.sidebar').sidebar('toggle');
  });

  showFlash();

  function showFlash() {
    if ($('header .flash-element').length > 0) {
      sleep(600).then(logoToFlash);
      sleep(8000).then(flashToLogo);
    };
  };

  function logoToFlash() {
    $('header .logo').transition('vertical flip', 500, () => {
      $('header .flash-element').transition('vertical flip');
    });
  };

  function flashToLogo() {
    $('header .flash-element').transition('vertical flip', 500, () => {
      $('header .logo').transition('vertical flip');
    });
  };

  function sleep(time) {
    return new Promise((resolve) => setTimeout(resolve, time));
  };

});

