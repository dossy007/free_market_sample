$(document).on('turbolinks:load', function(){
  $("#q_price").on("change", function () {
  var value = $("#q_price").val();
  if (value.length !== 0) { //全てが選択された時用
    var front = /(.*)(?=-)/
    var back = /(?<=-)(.*)/
    var minprice = value.match(front)[0]
    var maxprice = value.match(back)[0]

    $("#q_price_gteq").val(minprice)
    $("#q_price_lteq").val(maxprice)
  }else{
    $("#q_price_gteq").val("");
    $("#q_price_lteq").val("");
  }
  })
})
