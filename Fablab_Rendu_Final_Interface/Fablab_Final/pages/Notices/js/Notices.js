$(document).ready(function () {


    $('#file').change(function () {
        console.log('hello');
        var file = this.files[0],
            fileName = file.name,
            fileSize = file.size;
        $('.inside').text(fileName + " est le fichier choisi.");
    });

    $.ajax({
        url: "php/mysql-requete/Notices/choix_appareil.php",
        method: "POST",
        success: function (resultat) {
            $("#appareil_upload").html(resultat);
            $("#appareil_NFC_notices").html(resultat);
            $("#appareil_NFC_prises").html(resultat);
            $('#appareil_upload').awselect({
                background: "#4B49AC", //the dark blue background
                active_background: "#8987f5", // the light blue background
                placeholder_color: "white", // the light blue placeholder color
                placeholder_active_color: "#0f37a9", // the dark blue placeholder color
                option_color: "white", // the option colors
                vertical_padding: "15px", //top and bottom padding
                horizontal_padding: "20px", // left and right padding,
                immersive: false // immersive option, demonstrated at the next example
            });
        }
    });




    $.ajax({
        url: 'php/mysql-requete/Notices/view_download.php',
        type: 'post',
        success: function (response) {
            console.log(response);
            $('#link').html(response);
        }
    });

    var loading = "<div class=\"loader\">Loading...</div>";
    $('#btn_upload').click(function (e) {
        $('#return').html(loading);
        e.preventDefault();
        var formData = new FormData(this.form);
        $.ajax({
            url: 'php/mysql-requete/Notices/upload.php',
            type: 'post',
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                //window.location.href = response;
                $('#return').html(response);
                console.log(response);
            }
        });
    });



});
