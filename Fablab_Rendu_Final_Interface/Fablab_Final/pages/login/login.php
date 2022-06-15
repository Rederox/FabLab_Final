<?php

require("connexion.php");
$login = $_POST["login"];
$mdp = $_POST["mdp"];

if ($pdo) {

    $sql = "SELECT * FROM admin WHERE username=\"$login\" AND password=\"$mdp\"";

    $res = $pdo->prepare($sql);
    $exec = $res->execute();
    $ligne = $res->fetch(PDO::FETCH_ASSOC);

    //echo($login);

    if ($ligne["username"] == $login) {
        session_start();
        $_SESSION["login"] = $login;
        echo "../../";
        //header("location:Administrateur.php");  

    } else {

        echo "1";
    }
}
