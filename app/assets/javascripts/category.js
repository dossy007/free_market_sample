$(document).on('turbolinks:load', function() {
// jqをpage推移してきた時に動かす

	$("#item_category_id").on("change",function() {
		var value_id = $(this).val()
		console.log(value_id)

		// ajaxをajaxをajaxを空じゃない時に使用
		if(value_id !== ""){
			console.log("からではない")
			$.ajax({
				type: "GET",
				url:"/items/search",
				data:{value_id: value_id},
				dataType: "json"
			})

			.done(function(middle_category) {
				console.log(middle_category)
			})
		}
	})

})
