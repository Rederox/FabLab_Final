$(document).ready(function () {


    $('.a1').click(function (e) {
        $('.a1').addClass("active");
        $('.w1').fadeIn(100);
        $('.b1').removeClass('transform-out').addClass('transform-in');

        e.preventDefault();
    });

    $('.a2').click(function (e) {
        $('.a2').addClass("active");
        $('.w2').fadeIn(100);
        $('.b2').removeClass('transform-out').addClass('transform-in');

        e.preventDefault();
    });

    $('.a3').click(function (e) {
        $('.a3').addClass("active");
        $('.w3').fadeIn(100);
        $('.b3').removeClass('transform-out').addClass('transform-in');

        e.preventDefault();
    });

    $('.a4').click(function (e) {
        $('.a4').addClass("active");
        $('.w4').fadeIn(100);
        $('.b4').removeClass('transform-out').addClass('transform-in');

        e.preventDefault();
    });

    $('.a5').click(function (e) {
        $('.a5').addClass("active");
        $('.w5').fadeIn(100);
        $('.b5').removeClass('transform-out').addClass('transform-in');

        e.preventDefault();
    });

    $('.popup-close').click(function (e) {
        $('.a1').removeClass("active");
        $('.a2').removeClass("active");
        $('.a3').removeClass("active");
        $('.a4').removeClass("active");
        $('.a5').removeClass("active");

        $('.popup-wrap').fadeOut(100);
        $('.popup-box').removeClass('transform-in').addClass('transform-out');

        e.preventDefault();
    });


    $.ajax({
        url: "php/mysql-requete/Notices/choix_appareil.php",
        method: "POST",
        success: function (resultat) {
            $("#appareil_NFC_notices").html(resultat);
            $("#appareil_NFC_prises").html(resultat);
            $('#appareil_NFC_notices').awselect({
                background: "#4B49AC", //the dark blue background
                active_background: "#8987f5", // the light blue background
                placeholder_color: "white", // the light blue placeholder color
                placeholder_active_color: "#0f37a9", // the dark blue placeholder color
                option_color: "white", // the option colors
                vertical_padding: "15px", //top and bottom padding
                horizontal_padding: "10px", // left and right padding,
                immersive: false // immersive option, demonstrated at the next example
            });
            $('#appareil_NFC_prises').awselect({
                background: "#4B49AC", //the dark blue background
                active_background: "#8987f5", // the light blue background
                placeholder_color: "white", // the light blue placeholder color
                placeholder_active_color: "#0f37a9", // the dark blue placeholder color
                option_color: "white", // the option colors
                vertical_padding: "15px", //top and bottom padding
                horizontal_padding: "10px", // left and right padding,
                immersive: false // immersive option, demonstrated at the next example
            });
        }
    });


    var loading = "<div class=\"loader\">Loading...</div>";

    $('#btn_write_nfc').click(function (e) {

        e.preventDefault();
        var data = $('#write_notices').serialize();
        console.log(data[13]);
        if (data[13] == "0") {
            $('#return2').text("Choisissez un appareil");
        } else {
            $('#return2').html(loading);
            $.ajax({
                url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
                type: "POST",
                data: data,
                success: function (response) {
                    console.log(response);
                    $('#return2').html(response);
                }
            });
        }
    });

    $('#btn_gestion_prise').click(function (e) {

        e.preventDefault();
        var data = $('#write_gestion').serialize();

        if (data[13] == "0") {
            $('#return3').text("Choisissez un appareil");
        } else {
            $('#return3').html(loading);
            $.ajax({
                url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
                type: "POST",
                data: data,
                success: function (response) {
                    console.log(response);
                    $('#return3').html(response);
                }
            });
        }
    });

    $('#btn_write_url').click(function (e) {
        e.preventDefault();
        var data = $('#write_url').serialize();
        console.log(data);
        if (data[13] == "&") {
            $('#return4').text("Veuillez mettre un url");
        } else {
            $('#return4').html(loading);
            $.ajax({
                url: 'php/mysql-requete/NFC/UDP_client_NFC.php',
                type: "POST",
                data: data,
                success: function (response) {
                    console.log(response);
                    $('#return4').html(response);
                }
            });
        }
    });


});