$(document).on('turbolinks:load',function(){
  $('.review__icon--default').on('click',function(){
    $(this).animate({
      marginTop: "-100rem"
  },2000);
    $('.review__icon--default').css('pointer-events', "none");
  })
})
