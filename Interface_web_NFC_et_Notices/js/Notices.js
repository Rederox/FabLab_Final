$(document).ready(function () {


    $.ajax({
        url: 'php/mysql-requete/Notices/open.php',
        type: 'post',
        success: function (response) {
            $('#link').html(response);
        }
    });

    $('#btn_upload').click(function (e) {

        e.preventDefault();

        var formData = new FormData(this.form);
        console.log(formData);

        $.ajax({
            url: 'php/mysql-requete/Notices/upload.php',
            type: 'post',
            data: formData,
            contentType: false,
            processData: false,
            success: function (response) {
                // window.location.href = response;
                $('#return').html(response);
            }
        });
    });



});
