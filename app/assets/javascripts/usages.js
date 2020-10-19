
  $("#feature select").append('<option>Select feature</option>');
  $(document).on("change", "#sub select", function(){
  var country = $(this).val();

  $.ajax({
    url: "/users/new",
    method: "GET",
    dataType: "json",
    data: {country: country},
    error: function (xhr, status, error) {
      console.error('AJAX Error: ' + status + error);
    },
    success: function (response) {
      console.log(response);
      var cities = response["features"];
      $("#feature select").empty();

      $("#feature select").append('<option>Select feature</option>');
      for(var i=0; i<features.length; i++){
        $("#feature select").append('<option value="' + features[i]["id"] + '">' + features[i]["name"] + '</option>');
      }
    }
  });
});
