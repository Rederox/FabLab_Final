$(document).ready(function () {

    var appareil = localStorage.getItem("appareil");

    $.ajax({
        url: "../php/mysql-requete/reserver/nom_appareil.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $("#demo").html(resultat);
            //console.log(resultat);

        }
    });

    $.ajax({
        url: "../php/mysql-requete/reserver/eteint_allumer.php",
        method: "POST",
        data: {
            appareil: appareil,
            type: "number"
        },
        success: function (resultat) {
            localStorage.setItem("etat", resultat);
            console.log(localStorage.getItem("etat"));
        }
    });

    $.ajax({
        url: "../php/mysql-requete/reserver/eteint_allumer.php",
        method: "POST",
        data: {
            appareil: appareil,
            type: "letter"
        },
        success: function (resultat) {
            $("#button").html(resultat);
            //console.log(resultat);

        }
    });


});