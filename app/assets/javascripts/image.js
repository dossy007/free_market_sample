
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
  var form = 0 //MEMO: img_viewのhtmlを数える数
  var i_num = 0

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    if (form < 3) {
    form +=1
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
      var img = $(`<div class= "img_view" data-image-id="${i_num}"><img class="picture"></div>`);
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
      preview.append(img)
    }
    i_num += 1

    var html = $(`<li class="form-area" data-item-id="${i_num}" style="display: block; float: right; width: calc(100% - (157.5px * ${form}) ">
      <label class="dropzone-box" data-item-id="${i_num}" for="item_images_attributes_${i_num}_image">Image</label>
      <input class="upload-image" type="file" name="item[images_attributes][${i_num}][image]" id="item_images_attributes_${i_num}_image">
      </li>`)
    $(".formUploader").append(html)
    }
  });


    $(document).on('click','.btn_right',function() {
    var target_image = $(this).parent();
    var num = target_image.data("image-id")
    var get_form = $(`.form-area[data-item-id='${num}']`)

    form -=1
    target_image.remove()
    get_form.remove()
    preview.css({
      'width': '-=157.5px'
    });
    dropzone.css({
      'float' :'right'
    });

    //MEMO: li .form-areaのlastのcssを調整
    var last_form = $(".form-area:last")
    last_form.css({
      'width': `calc(100% - (157.5px * ${form}))`
    })

    $('input[type= "file"].upload-image:first').attr({
      'data-image': inputs.length
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

  }
  //newはここまで

  //editはここから
  if (window.location.href.match(/\/items\/\d+\/edit/)) {
    var length = $(".img_view").length
    var item_length = parseInt(length)
    var inputs = [];
    var images = [];
    if (item_length < 3) {
    $(document).on('change', 'input[type= "file"].upload-image',function(event) {
      var file = $(this).prop('files')[0];
      //input_fileの中身をキャンセルした場合
      if (file !== undefined) {
        var reader = new FileReader();
        var form_class =$(this).parent()
        var form_class_next =$(this).parent().next()
        var formData = new FormData();
        var type_file = $("input[type=file]").prop('files')[0];

        formData.append('file',type_file)
        var url = $(".edit_item").attr('action')
        var num = url.match(/\d/)
        var action_url = url + `/api/items/${num}`
        var length = $(".img_view").length

        if (length < 3) {
          $.ajax({
            url: action_url,
            type: 'PATCH',
            data: formData,
            dataType: 'json',
            processData: false,
            contentType: false
          })

          .done(function(image) {
            var img = $(`<div class= "img_view" data-item-id="${image.id}"><img class="picture"></div>`);
            reader.onload = function(e) {
            var btn_wrapper = $('<p class="btn_left">編集</p><p class="btn_right">削除</p>');
            img.append(btn_wrapper);
            img.find('img').attr({
              src: e.target.result
            })
            }
            reader.readAsDataURL(file);
            images.push(img);
              if (item_length == 0) {
                $(".form-areas").before(img);
              }else{
              $(".img_view:last").after(img);
              }
              item_length = parseInt(item_length)+1
              })
            .fail({
            })
        }

      }
    });

  }

  // deletebtn
    $(document).on('click','.btn_right',function() {
      var parent_content = $(this).parent()
      var data_id = $(parent_content).data('item-id')
      var edit_action = $(".edit_item").attr('action')
      parent_content.remove()
      var num = edit_action.match(/\d/)
      item_length = parseInt(item_length)-1
      $.ajax({
        url: `/items/${num}/api/items/${data_id}`,
        type: 'DELETE',
        data: {name: data_id
        },
        dataType: 'json',
        contentType: false
      })
    })

    }//editはここまで
});
