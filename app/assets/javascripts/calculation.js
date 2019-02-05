$(document).on('turbolinks:load', function() {

  $(".price-base__form").on("keyup", function(){

    let input = $(".price-base__form").val();

    if(input >= 300){

      let commission = 0.1;
      let itemCommission = Math.floor(input * commission);
      let itemProfit = (input - itemCommission);

      const formatter = new Intl.NumberFormat('ja-JP', {
        style: 'currency',
        currency: 'JPY'
      });

      $(".fee-right").text(formatter.format(itemCommission));
      $(".profit-right").text(formatter.format(itemProfit));

    }else{
      $(".fee-right").text("-");
      $(".profit-right").text("-");
    }
  });
});
