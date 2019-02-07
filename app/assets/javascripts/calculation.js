$(document).on('turbolinks:load', function() {
  $(function(){

    const formatter = new Intl.NumberFormat('ja-JP', {
      style: 'currency',
      currency: 'JPY'
    });

    $(".price-base__form").on("keyup", function(){

      let input = $(".price-base__form").val();

      let commission = 0.1;
      let itemCommission = Math.floor(input * commission);
      let itemProfit = (input - itemCommission);

      if(input >= 300 && input <= 9999999){
        $(".fee-right").text(formatter.format(itemCommission));
        $(".profit-right").text(formatter.format(itemProfit));
      }else{
        $(".fee-right").text("-");
        $(".profit-right").text("-");
      }
    });


    $('.buy__accordion-parent').on('click', function(){
      $('.buy__accordion-child').show();
    });


    let usersPoint = $('.user-point').text().match(/[0-9]+/);
    let paymentPrice = $('span.buy__price-cell').text();

    $('.buy__input-default').on('keyup', function(){

      let inputPoint = $(this).val();
      let restPoint = usersPoint - inputPoint;
      let replacePrice = paymentPrice - inputPoint;

      //ポイント入力欄が空白、又は入力欄の数字が所持ポイント以下の場合に実行
      if (inputPoint != "" && restPoint >= 0 || inputPoint == "") {
        $('.point-alert').hide();
        $('.user-point span').text(restPoint);
        $('span.buy__price-cell').text(formatter.format(replacePrice));
        buyPrice = $('span.buy__price-cell').attr('value', replacePrice);
      }else{
        $('.point-alert').show();
        $('.user-point span').text(usersPoint);
        $('span.buy__price-cell').text(paymentPrice);
      }
    });
  });
});
