
$('.more-options a').click(function(e) {
  $(this).next('.additional-options').slideToggle();
  e.preventDefault();
});
