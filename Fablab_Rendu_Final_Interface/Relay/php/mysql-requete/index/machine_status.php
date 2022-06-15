<?php

require("../../mysql-connexion/connexion.php");

$status = $_POST["appareil"];

$etat = "SELECT Etat,maintenance,Numero_appareil,utilisateur,Heure_debut FROM Etat_appareil where Numero_appareil = '$status' ";
$info_user = "SELECT Nom,Prénom FROM inscrit I, Etat_appareil E WHERE I.Utilisateur=E.utilisateur && E.Numero_appareil=$status;";

if ($pdo) {
    //requete status
    $res =  $pdo->prepare($etat);
    $res->execute();
    $colonne_stat = $res->fetch(PDO::FETCH_ASSOC);
    //requete info user
    $res2 =  $pdo->prepare($info_user);
    $res2->execute();
    $colonne_info = $res2->fetch(PDO::FETCH_ASSOC);

    if ($colonne_stat["Etat"] == "eteint" && $colonne_stat["maintenance"] == "bien") {
        echo "<a class=\"green\" id=\"status\"> Disponible </a>";
        echo "<button id=\"use\" type=\"button\" onclick=\"window.location.href='html/reserver.html'\">Utiliser</button>";
    } elseif ($colonne_stat["Etat"] == "allumer" && $colonne_stat["maintenance"] == "bien") {
        echo "<a class=\"red\" id=\"status\">La machine est reserver par " . $colonne_info["Nom"] . " " . $colonne_info["Prénom"] . " depuis " . $colonne_stat["Heure_debut"] . " </a>";
        echo "<button id=\"use\" type=\"button\" onclick=\"window.location.href='html/reserver.html'\" >Utiliser</button>";
    } elseif ($colonne_stat["maintenance"] == "panne") {
        echo "<a class=\"red\" id=\"status\"> Il est actuellement en panne, veilleuz patientez </a>";
    } else {
        echo "nul";
    }
}
