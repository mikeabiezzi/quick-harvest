$(document).ready(function() {

  $('.main').load('/ .main', function() {

    $('.display-option input').change(function() {
      if($(this).is(":checked")) {
        $('.doesnt-need-entry').hide();
      } else {
        $('.doesnt-need-entry').show();
      }
    });

    $('form').submit(function(){
      $('input[type=submit]').prop('disabled', true);
    });

  });

});
