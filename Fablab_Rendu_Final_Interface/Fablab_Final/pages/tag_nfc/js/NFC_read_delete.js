$(document).ready(function () {
    var loading = "<div class=\"loader\">Loading...</div>";

    $('#btn_read_nfc').click(function (e) {
        console.log(loading);
        $('#return5').html(loading);
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
                $('#return5').html(response);
            }
        });
    });


    $('#btn_delete_nfc').click(function (e) {
        $('#return6').html(loading);
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
                $('#return6').html(response);
            }
        });
    });


});