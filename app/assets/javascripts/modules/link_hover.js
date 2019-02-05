$(document).on('turbolinks:load', function() {
  $('.prof__mypage-nav-list-item').hover(
    function(){
    $(this).css('background-color', '#f5f5f5');
    $(this).children().animate(
      {
        'color': 'black',
        'font-size' : '2.8rem',
        'margin-right' : '-0.4rem'
      }, 200);
    },
    function(){
    $(this).css('background-color', '#fff');
    $(this).children().animate(
      {
        'color': '#ccc',
        'font-size' : '2.5rem',
        'margin-right' : 'none'
      }, 200);
    });
});

