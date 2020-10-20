jQuery(function(){
  $( "#usage_subscription_id" ).change(function() {

  var subscription = $(this).val();
  $.ajax({
    url: "/usages/new",
    method: "GET",
    dataType: "json",
    data: {subscription: subscription},
    error: function (xhr, status, error) {
      console.error('AJAX Error: ' + status + error);
    },
    success: function (response) {
      console.log(response);
      var features = response["features"];
      $("#usage_feature_id").empty();
      $("#usage_feature_id").append('<option>Select feature</option>');
      for(var i=0; i<features.length; i++){
        $("#usage_feature_id").append('<option value="' + features[i]["id"] + '">' + features[i]["name"] + '</option>');
      }
    }
  });
});
});
