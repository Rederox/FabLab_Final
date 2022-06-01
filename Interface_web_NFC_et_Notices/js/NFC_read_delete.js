$(document).ready(function () {

    $('#btn_read_nfc').click(function (e) {

        e.preventDefault();
        //var data = $('#read').serialize();
        var choix = $('#read_val').val();
        var appareil_NFC = "none";

        $.ajax({
            url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
            type: "POST",
            data: {
                choix: choix,
                appareil_NFC: appareil_NFC
            },
            success: function (response) {
                console.log(response);
                $('#return3').html(response);
            }
        });
    });


    $('#btn_delete_nfc').click(function (e) {
        e.preventDefault();
        var choix = $('#delete_val').val();
        var appareil_NFC = "none";
        $.ajax({
            url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
            type: "POST",
            data: {
                choix: choix,
                appareil_NFC: appareil_NFC
            },
            success: function (response) {
                console.log(response);
                $('#return4').html(response);
            }
        });
    });


});