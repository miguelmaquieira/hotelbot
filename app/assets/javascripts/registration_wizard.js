$(function() {
  $('#registration_wizard').wizard({
    disablePreviousStep: true
  });
  if (step_value > 1) {
    $('#registration_wizard').wizard('selectedItem', {
      step: step_value
    });
  }

  $('.toggle-ambiance').bootstrapSwitch();

  $(".age_picker").selectpicker({
    width: 200
  });
  $(".gender_picker").selectpicker({
    width: 200
  });
  $(".usually_picker").selectpicker({
    width: 200
  });


});
