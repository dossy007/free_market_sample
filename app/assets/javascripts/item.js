$(document).on('turbolinks:load', function(){
	$("#content_link").on("click",function() {
		if(!confirm("本当に削除しますか？")){
			return false;
			// キャンセル時何もしない
		}else{
			return true
			//OK時 item削除
		}
	})
})
