<?php

require("../../mysql-connexion/connexion.php");

$appareil = $_POST["appareil"];
$etat = "SELECT `astuce` FROM `index` where Numero_appareil = '$appareil' ";

if ($pdo) {
    $res =  $pdo->prepare($etat);
    $res->execute();
    $colonne = $res->fetch(PDO::FETCH_ASSOC);
    echo $colonne['astuce'];
}
