$(document).ready(function () {

    $(document).on('submit', '#Form1', function (event) {
        event.preventDefault();
    });
    var appareil = localStorage.getItem("appareil");
    var etat = localStorage.getItem("etat");
    console.log(etat + appareil);

    $("#button").click(function () {
        var test;
        var login = $('#login').val();
        var mdp = $('#mdp').val();
        var appareil = localStorage.getItem("appareil");
        var etat = localStorage.getItem("etat");
        console.log(etat + appareil);
        //----------------------------------------------------------------
        var incorrect = "L'utilisateur ou le mot de passe est incorrect";
        var bad_user = "Ce n'est pas le bon utilisateur";
        $.ajax({
            url: "../php/mysql-requete/reserver/connecter.php",
            method: "POST",
            data: {
                login: login,
                mdp: mdp,
                appareil: appareil,
                etat: etat
            },
            success: function (resultat) {
                console.log(resultat);
                if(resultat == 1) {
                    console.log(incorrect);
                    $("#retour_login").html(incorrect);
                }
                else if(resultat == 2) {
                    console.log(bad_user);
                    $("#retour_login").html(bad_user);
                } else {
                    //partie UDP allumer ou eteindre
                    $.ajax({
                        url: "../php/mysql-requete/reserver/udp_client.php",
                        method: "POST",
                        data: {
                            appareil: appareil,
                            etat: etat
                        },
                        success: function (resultat) {

                        }
                    });
                    window.location.href = resultat;
                }
            }
        });

    });

});