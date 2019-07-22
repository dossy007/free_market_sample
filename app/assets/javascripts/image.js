$(function() {

 function readURL(input) {
   if (input.files && input.files[0]) {
     var reader = new FileReader();
     reader.onload = function (e) {
     	//onloadは画像などを読み込んでから実行の意味
 		 console.log(input)
 		 $('#img').attr('src', e.target.result);
 		 // srcを取得する
     }
     reader.readAsDataURL(input.files[0]);
     //取得したsrcをreaderで読み込み
   }
 }

 $("#item_images_attributes_0_image").change(function(){
   readURL(this);
   //inputの中身が変わればreadURLが発火
 });
});
