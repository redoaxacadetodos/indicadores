$(function() {
  // Smooth Scroll
  $('a[href*=#]').bind('click', function(e) {
    var anchor = $(this);
    $('html, body').stop().animate({
      scrollTop: $(anchor.attr('href')).offset().top
    }, 1000);
    e.preventDefault();
  });
});

$('.i-accordion').on('show.bs.collapse', function(n) {
  $(n.target).siblings('.panel-heading').find('.panel-title i').toggleClass('fa-chevron-down fa-chevron-up');
});
$('.i-accordion').on('hide.bs.collapse', function(n) {
  $(n.target).siblings('.panel-heading').find('.panel-title i').toggleClass('fa-chevron-up fa-chevron-down');
});

/* P */
$('.p-accordion, .q-accordion').on('show.bs.collapse', function(n) {
  $(n.target).siblings('.panel-heading').find('.panel-title i').toggleClass('fa-minus fa-plus');
});
$('.p-accordion, .q-accordion').on('hide.bs.collapse', function(n) {
  $(n.target).siblings('.panel-heading').find('.panel-title i').toggleClass('fa-plus fa-minus');
});