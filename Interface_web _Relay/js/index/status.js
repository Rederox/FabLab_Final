var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = window.location.search.substring(1),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for(i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if(sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : decodeURIComponent(sParameterName[1]);
        }
    }
    return false;
};

$(document).ready(function () {

    var appareil = getUrlParameter('appareil');;
    localStorage.setItem("appareil", appareil);

    $.ajax({
        url: "php/mysql-requete/index/machine_status.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $("#idbutton").html(resultat);
        }
    });

    $.ajax({
        url: "php/mysql-requete/index/titre.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $(".titre1").html(resultat);
        }
    });

    $.ajax({
        url: "php/mysql-requete/index/image.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $("#image").html(resultat);
        }
    });

    $.ajax({
        url: "php/mysql-requete/index/description.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $("#description1").html(resultat);
        }
    });

    $.ajax({
        url: "php/mysql-requete/index/description2.php",
        method: "POST",
        data: {
            appareil: appareil
        },
        success: function (resultat) {
            $("#description2").html(resultat);
        }
    });



});