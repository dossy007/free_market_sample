$(document).on('turbolinks:load', function() {
// jqをpage推移してきた時に動かす

	$("#item_category_id").on("change",function() {
		console.log("11")
		var tt =$(this).val()
		console.log(tt)
		if(tt === ""){
			console.log("からやで")
		}
	})

})
