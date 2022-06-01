

$(document).ready(function () {

    $(".l1").click(function () {
        show("Box1", "Box2", "Box3");
    });

    $(".l2").click(function () {
        show("Box2", "Box1", "Box3");
    });

    $(".l3").click(function () {
        show("Box3", "Box1", "Box2");
    });


    function show(shown, hidden, hidden2) {

        $("." + shown).css("display", "unset");
        $("." + hidden).css("display", "none");
        $("." + hidden2).css("display", "none");
        return false;

    }

});