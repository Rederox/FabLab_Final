$(document).ready(function () {


    $.ajax({
        url: "php/mysql-requete/Notices/choix_appareil.php",
        method: "POST",
        success: function (resultat) {
            $("#appareil_upload").html(resultat);
            $("#appareil_NFC_notices").html(resultat);
            $("#appareil_NFC_prises").html(resultat);
        }
    });


    $('#btn_write_nfc').click(function (e) {

        e.preventDefault();
        var data = $('#write_notices').serialize();
        $.ajax({
            url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
            type: "POST",
            data: data,
            success: function (response) {
                console.log(response);
                $('#return2').html(response);
            }
        });
    });

    $('#btn_gestion_prise').click(function (e) {

        e.preventDefault();
        var data = $('#write_gestion').serialize();
        console.log(data);
        $.ajax({
            url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
            type: "POST",
            data: data,
            success: function (response) {
                console.log(response);
                $('#return5').html(response);
            }
        });
    });



});