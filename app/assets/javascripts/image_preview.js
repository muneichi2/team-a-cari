$(document).on('turbolinks:load', function() {

  function buildLabelHTML(attributesNum) {
    let html =
              `<label class="upload__drop-box" for="item_item_images_attributes_${attributesNum}_image">
                  <pre class="drop-text">ドラッグアンドドロップ<br>またはクリックしてファイルをアップロード</pre>
                  <input type="file" class="hidden" name="item[item_images_attributes][${attributesNum}][image]" id="item_item_images_attributes_${attributesNum}_image">
              </label>`
    return html;
  }

  let imgCount = $(".sell-upload-items li").length;

  if (imgCount !== 0) {
    attributesNum = imgCount
    $('label').find('input[type="file"]').each(function() {
      $(this).parent().hide();
    });
    if (imgCount <= 4) {
      $(".sell-upload-items-container").append(buildLabelHTML(attributesNum));
    }
    attributesNum += 1

    let boxSize = 100 - (20 * imgCount);
    $('.upload__drop-box').each(function() {
      if ($(this).css('display') == 'block' ) {
        $(this).css('width', boxSize + '%');
      }
    });
  }else{
    attributesNum = 1
  }


  $("form").on('change', 'input[type="file"]', function(e){

    let file = e.target.files[0];
    let reader = new FileReader();

    let numArray = [];
    $('label').find('input[type="file"]').each(function( i, inputFile ) {
      numArray.push(inputFile.id.match(/[0-9]+/));
    });

    let inputNum = Math.max.apply(null, numArray)

    reader.onload = function(){
      function appendListHTML(inputNum) {
        let html =
                  `<li class="sell-upload-item">
                      <img alt="" class="preview-image image${inputNum}">
                      <div class="sell-upload-item__button">
                        <a class="sell-upload-edit">編集</a><a class="sell-upload-delete" data-image-number=${inputNum}>削除</a>
                      </div>
                  </li>`
        return html;
      }

      let imgSrc = reader.result;
      $(".sell-upload-items ul").append(appendListHTML(inputNum))
      $(".image" + inputNum).attr("src", imgSrc)

      $('label').find('input[type="file"]').each(function() {
        if ($(this)[0].files[0]) {
          $(this).parent().hide();
        }
      });

      let imgCount = $(".sell-upload-items li").length

      if (imgCount >= 5) {
        return false
      }else{
        $(".sell-upload-items-container").append(buildLabelHTML(attributesNum));

        let boxSize = 100 - (20 * imgCount);
        $('.upload__drop-box').each(function() {
          if ($(this).css('display') == 'block' ) {
            $(this).css('width', boxSize + '%');
          }
        });
      }

      attributesNum += 1;

    };
    reader.readAsDataURL(file);
  });

  $(document).off("click", ".sell-upload-delete");
  $(document).on("click", ".sell-upload-delete", function(){

    $(this).parent().parent().remove();

    let deleteNum = $(this).data('image-number')

    $('label').find('input[type="file"]').each(function( i, targetFile ) {
      if (targetFile.id.match(/[0-9]+/) == deleteNum) {
        $(targetFile).prev('#delete').prop('checked', true)
      }
    });

    let imgCount = $(".sell-upload-items li").length
    if (imgCount == 4) {
      $(".sell-upload-items-container").append(buildLabelHTML(attributesNum));
      attributesNum += 1;
    }

    let boxSize = 100 - (20 * imgCount);
    $('.upload__drop-box').each(function() {
      if ($(this).css('display') == 'block' ) {
        $(this).css('width', boxSize + '%');
      }
    });

  });
});
