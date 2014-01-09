$(document).ready(function() {
  $('.display-option input').change(function() {
    if($(this).is(":checked")) {
      $('.doesnt-need-entry').hide();
    } else {
      $('.doesnt-need-entry').show();
    }
  });
});
