

$(document).on('turbolinks:load', function(){
  var dropzone = $('.form-area');
  var dropzone2 = $('.form-area2');
  var dropzone_box = $('.dropzone-box');
  var images = [];
  // ボタンがついたhtmlの情報
  var inputs  =[];
  var input_area = $('.form_area');
  // inputするfilefieldの上のclass
  var preview = $('#list');
  var preview2 = $('#list2');
//jquryobjectにしている

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    // imageがinputに入ったら
    var file = $(this).prop('files')[0];
    // fileを取得
    if (file !== undefined) {  //fileの中身をキャンセルした時用
      var reader = new FileReader();
      // data-idを取得
      var form_id =$(this).parent().data('item-id')
      var form_class =$(this).parent()
      form_class.css({
          'display': 'none'
      })

      console.log(form_class)

      // dropzone_box.css({
      //     'display': 'none'
      //   })
      //filereaderのインスタンス作成
      inputs.push($(this));
      //配列にfileをpush
      var img = $(`<div class= "img_view"><img class="picture"></div>`);
      // imgclassを持つ変数を定義
      reader.onload = function(e) {
        //onloadでfileを読み込む
        var btn_wrapper = $('<p class="btn_left">編集</p><p class="btn_right">削除</p>');
        //削除などのボタンのclassを定義
        img.append(btn_wrapper);
        // imgclassを持つ変数にボタンをappend
        img.find('img').attr({
          // imgからimgを探しsrcをresultとして返す
          src: e.target.result
        })
      }
      reader.readAsDataURL(file);
      //readerでfilefileを取得
      images.push(img);
      // 配列にボタンがついたhtmlを入れ込む
      preview.css({
        'width': '+=157.5px'
      });
      dropzone.css({
        'float' :'right'
      });
      if(images.length == 4) {
        dropzone_box.css({
          'display': 'none'
        })
      }


      //   if(images.length == 9) {
      //     // 配列の数が9なら
      //     dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
      //     // id2のpをiclassにreplace
      //   }
      // } else {
        // 配列が9以外なら
          // $('#preview').empty();
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (157.5px * ${images.length}))`
      })
    }
  });



  $(document).on('click', '.delete', function() {
    var target_image = $(this).parent().parent();
    $.each(inputs, function(index, input){
      if ($(this).data('image') == target_image.data('image')){
        $(this).remove();
        target_image.remove();
        var num = $(this).data('image');
        images.splice(num, 1);
        inputs.splice(num, 1);
        if(inputs.length == 0) {
          $('input[type= "file"].upload-image').attr({
            'data-image': 0
          })
        }
      }
    })
    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
    })
    $.each(inputs, function(index, input) {
      var input = $(this)
      input.attr({
        'data-image': index
      })
      $('input[type= "file"].upload-image:first').after(input)
    })
    if(images.length == 4) {
      dropzone_box.css({
        'display': 'none'
      })
    }
    if(images.length == 3) {
      dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
    }
  })
});

