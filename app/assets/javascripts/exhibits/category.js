$(document).on('turbolinks:load', function() {

  function buildSubCategoryHTML(){
    let html =
      `<div class= "category-wrap sub-category" >
        <select class="select-category sub-category name="item[category]">
          <option value>---</option>
        <i class="fa fa-angle-down category-icon"></i>
      </div>`
    return html;
  }

  function appendOptionsHTML(child){
    let html =
              `<option value="${child.id}">${child.name}</option>`
    return html;
  }

  function buildThirdCategoryHTML(){
    let html =
      `<div class= "category-wrap third-category" >
        <select class="select-category third-category name="item[category]">
          <option value>---</option>
        <i class="fa fa-angle-down category-icon"></i>
      </div>`
    return html;
  }

  function addOptionsHTML(child){
    let html =
              `<option value="${child.id}">${child.name}</option>`
    return html;
  }

  $('.top-category').change(function(){

    $('.sub-category').remove();
    $('.third-category').remove();

    let topCategory = $('.top-category').val();

    $('.category-form').append(buildSubCategoryHTML());

    if(topCategory !== ""){
      $.ajax({
        type: 'GET',
        url: '/items/new',
        data: { parent_id: topCategory },
        dataType: 'json'
      })
      .done(function(children){
        children.forEach(function(child){
          $('.select-category.sub-category').append(appendOptionsHTML(child))
        });
      })
      .fail(function() {
        alert('カテゴリー情報取得に失敗しました')
      });
    }else{
      $('.sub-category').remove();
      $('.third-category').remove();
    }
  });


  $(document).on('change', '.sub-category', function(){

    $('.third-category').remove();

    let subCategory = $('select.sub-category').val();

    $('.category-form').append(buildThirdCategoryHTML());

    if(subCategory !== ""){
      $.ajax({
        type: 'GET',
        async: false,
        url: '/items/new',
        data: { parent_id: subCategory },
        dataType: 'json'
      })
      .done(function(children){
        children.forEach(function(child){
          $('select.third-category').append(addOptionsHTML(child))
        });
      })
      .fail(function() {
        alert('カテゴリー情報取得に失敗しました')
      });
    }
  });

  $('.exhibit-button').on('click', function(){
    let categoryId = $('select.third-category').val();
    $('select.top-category > option:selected').attr('value',categoryId)
  });

});
