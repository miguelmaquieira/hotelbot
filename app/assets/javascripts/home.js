$(function() {

  $('.image-box').hover(
    function() {
      $(this).find('.actions').slideDown(250); //.fadeIn(250)
    },
    function() {
      $(this).find('.actions').slideUp(250); //.fadeOut(205)
    }
  );

});

