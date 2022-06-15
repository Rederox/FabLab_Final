$(document).ready(function() {
  $(".noDisplay").css('visibility','visible');
  $('#textManuel').prop("required",true);
  var id = $('#show').text();
  var toSend = { id: id }
  $.ajax({
    type: "POST",
    url: "PHP/jquery.php",
    data: toSend,
    cache: false,
    success: function(data) {
      var jsonData = JSON.parse(data);
      $('#textManuel').prop("value",jsonData.badgeID);
    },
    error: function(xhr) {
      console.error(xhr);
    }
  });
});
