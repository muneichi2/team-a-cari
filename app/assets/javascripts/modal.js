$(document).on('turbolinks:load', function(){

  $('.btn-default.btn-red.delete').on('click', function(){
    $('.overlay').fadeIn();
    $('.modal').fadeIn();
    $('html, body').css('overflow', 'hidden');
  });

  $('.overlay').on('click', function(){
    $('.overlay').fadeOut();
    $('.modal').fadeOut();
    $('html, body').removeAttr('style');
  });

  $('.modal__btn--cancel').on('click', function(){
    $('.overlay').fadeOut();
    $('.modal').fadeOut();
    $('html, body').removeAttr('style');
  });

  $('.modal__delete--btn').on('click', function(){
    $('html, body').removeAttr('style');
  });
});


