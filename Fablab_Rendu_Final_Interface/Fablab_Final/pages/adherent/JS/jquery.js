$(document).ready(function() {

  $("#manuel").click(function(){ //si la radio manuel est selectionné
    $(".noDisplay").css('visibility','visible');
    $('#textManuel').prop("required",true); // ajouter l'attribut obligatoire de l'entrée clavier lors que c'est selectionné
  })

  $("#auto").click(function(){  //si la radio automatique est selectionné
    $(".noDisplay").css('visibility','hidden');
    $('#textManuel').prop("required",false); //retirer l'attribut obligatoire de l'entrée clavier
  })

  $("#manuelEdit").click(function(){
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
  })
});
