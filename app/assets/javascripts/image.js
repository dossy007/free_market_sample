
$(document).on('turbolinks:load', function(){

  //newの時のみ
  if (window.location.href.match(/\/items\/new/)) {

  var dropzone = $('.form-area');
  var dropzone2 = $('.form-area2');
  var dropzone_box = $('.dropzone-box');
  var images = [];
  var inputs  =[];
  var input_area = $('.form_area');
  var preview = $('#list');
  var preview2 = $('#list2');
  var form = $(".img_view").length


if (form < 3) {
  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];

    //input_fileの中身をキャンセルした場合
    if (file !== undefined) {
      var reader = new FileReader();
      var form_class =$(this).parent()
      var form_class_next =$(this).parent().next()
      form_class.css({
          'display': 'none'
      })
      form_class_next.css({
          'display': 'block'
      })
      inputs.push($(this));
      var img = $(`<div class= "img_view"><img class="picture"></div>`);
      reader.onload = function(e) {
        var btn_wrapper = $('<p class="btn_left">編集</p><p class="btn_right">削除</p>');
        img.append(btn_wrapper);
        img.find('img').attr({
          src: e.target.result
        })
      }
      reader.readAsDataURL(file);
      images.push(img);
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

      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (157.5px * ${images.length}))`
      })
    }
  });


  $(".btn_right").on('click','.for', function() {
    var target_image = $(this).parent();
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

