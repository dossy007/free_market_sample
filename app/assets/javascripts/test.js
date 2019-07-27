function handleFileSelect(files) {
    for (var i = 0, f; f = files[i]; i++) {
      var reader = new FileReader();

      reader.onload = (function(theFile) {
        return function(e) {
          var span = $(document.createElement('span'));

          var html = ['<img class="thumb" src="', e.target.result,
                            '" title="', escape(theFile.name), '"/>'].join('');
          span.html(html)
          $('#list').append(span);
          let scsss = $(".form-area")
          scsss.css("width","calc(100%-10px")
        };
      })(f);

      reader.readAsDataURL(f);
    }
  }

  function handleDragOver(evt) {
    evt.stopPropagation();
    evt.preventDefault();
    evt.dataTransfer.dropEffect = 'copy';
  }

  window.onload = function(){
  var dropZone = document.getElementById('dropzone');

  console.log(dropZone)
  dropZone.addEventListener('dragover', handleDragOver, false);
  $("#dropzone").on("drop", function(_evt) {
    var evt = _evt;
    if (_evt.originalEvent) {
      evt = _evt.originalEvent;
    }
    evt.stopPropagation();
    evt.preventDefault();
    var dt = evt.dataTransfer;
    var files = dt.files;
    handleFileSelect(files);
  })
  }
