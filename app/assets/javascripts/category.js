	$(document).on('turbolinks:load', function() {
		var cat_id = $("#category")

		function appendOption(num) {
			if (num === 1){
				var option_id = "middle_category"
			}else if (num === 2) {
				var option_id = "sub_category"
			}
			var html =
			`<select name="item[category_id]" class="inputField inputField__select" id=${option_id} required="required">
					<option value>---</option>
			 </select>`
			 cat_id.append(html)
		}

		function appendCategory(category, num) {
			if(num == 1) {
				var append_id = $("#middle_category")
			}else if (num == 2) {
				var append_id = $("#sub_category")
			}
			append_id.append(
				$("<option>")
				.val($(category).attr("id"))
				.text($(category).attr("name"))
			)
		}

		$("#item_category_id").on("change",function() {
			var value_id = $(this).val()
			$("#middle_category").remove()
			$("#sub_category").remove()

			// value_idが空ではない時にajazを使用
			if(value_id !== ""){
				$.ajax({
					type: "GET",
					url:"/items/search",
					data:{value_id: value_id},
					dataType: "json"
				})

				.done(function(middle_category) {
					appendOption(1)
					middle_category.forEach(function(middle) {
						appendCategory(middle, 1)
					})
				})
			}
		})

	//動的に追加したhtmlはdocument.onで指定
		$(document).on("change","#middle_category",function() {
			console.log("11")
			middle_c = $(this).val()
			$("#sub_category").remove()
			console.log(middle_c)

			$.ajax({
				type: "GET",
				url: "/items/search",
				data: {middle_id: middle_c},
				dataType: "json"
			})
			.done(function(sub_category) {
				console.log(sub_category)
				appendOption(2)
				sub_category.forEach(function(sub){
					appendCategory(sub,2)
				})

			})
		})

	})
