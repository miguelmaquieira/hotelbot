$(function(){
  $('.hotel-widget-container').hover(
    function() {
      $(this).find('.actions').slideDown(250); //.fadeIn(250)
    },
    function() {
      $(this).find('.actions').slideUp(250); //.fadeOut(205)
    }
  );
  $('.match-container').hover(
    function() {
      $(this).find('.matchers').slideDown(250); //.fadeIn(250)
    },
    function() {
      $(this).find('.matchers').slideUp(250); //.fadeOut(205)
    }
  );
});
