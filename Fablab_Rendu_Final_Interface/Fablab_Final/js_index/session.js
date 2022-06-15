$(document).ready(function () {

    setInterval(function () {
        refresh()
    }, 1000);

    $.ajax({
        url: 'php/session.php',
        type: 'post',
        success: function (response) {
            $('#name').html(response);

        }
    });

    $.ajax({
        url: 'php/date.php',
        type: 'post',
        success: function (response) {
            $('#date').html(response);

        }
    });
    function refresh() {
        $.ajax({
            url: 'php/presents.php',
            type: 'post',
            success: function (response) {
                $('#presents').html(response);

            }
        });

        $.ajax({
            url: 'php/machine.php',
            type: 'post',
            success: function (response) {
                $('#allumer').html(response);

            }
        });

        $.ajax({
            url: 'php/total_presents.php',
            type: 'post',
            success: function (response) {
                $('#total_presents').html(response);
            }
        });

        $.ajax({
            url: 'php/total_machine.php',
            type: 'post',
            success: function (response) {
                $('#total_machine').html(response);

            }
        });

        $.ajax({
            url: 'php/personne_present.php',
            type: 'post',
            success: function (response) {
                $('#personne_present').html(response);

            }
        });

        $.ajax({
            url: 'php/machine_allumer.php',
            type: 'post',
            success: function (response) {
                $('#machine_allumer').html(response);
                console.log(response);

            }
        });
    }
});

