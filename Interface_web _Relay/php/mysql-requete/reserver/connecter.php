<?php

require("../../mysql-connexion/connexion.php");

setlocale(LC_TIME, "fr_FR");
$heurefr = strftime('%H:%M:%S');
$jourfr = strftime("%y-%m-%d");

$login = $_POST["login"];
$mdp = $_POST["mdp"];
$etat = $_POST["etat"];
$appareil = $_POST["appareil"];

$sql_login = "select count(*) as nombre from inscrit where Utilisateur = \"$login\" && Mot_de_passe = \"$mdp\"";
$sql_last_user = "SELECT * FROM `Etat_appareil` WHERE `Numero_appareil` = $appareil; ";

if ($etat == 2) {
    $sql_on_off = "UPDATE `Etat_appareil` SET `Etat` = 'eteint' , `utilisateur` = 'personne', `Heure_fin` = '$heurefr', `Duree_totale` = TIMEDIFF(Heure_fin,Heure_debut)  WHERE `Etat_appareil`.`Numero_appareil` = $appareil;";
} elseif ($etat == 1) {
    $sql_on_off = "UPDATE `Etat_appareil` SET `Etat` = 'allumer',`utilisateur` = '$login', `Heure_debut` = '$heurefr' WHERE `Etat_appareil`.`Numero_appareil` = $appareil;";
}





if ($pdo) {
    $res = $pdo->prepare($sql_login);
    $res->execute();
    $colonne = $res->fetch(PDO::FETCH_ASSOC);


    if ($etat == 1) {
        if ($colonne["nombre"] == 1) {
            $res2 = $pdo->prepare($sql_on_off);
            $res2->execute();

            echo "../index.html?appareil=$appareil";
        } else {
            echo "1";
        }
    } elseif ($etat == 2) {

        $res3 = $pdo->prepare($sql_login);
        $res3->execute();
        $colonne3 = $res3->fetch(PDO::FETCH_ASSOC);

        if ($colonne3["nombre"] == 1) {
            $res4 = $pdo->prepare($sql_last_user);
            $res4->execute();
            $colonne4 = $res4->fetch(PDO::FETCH_ASSOC);

            if ($colonne4["utilisateur"] == "$login") {
                // Recuperer nom et prenom
                $info_user = "SELECT Nom,Prénom FROM inscrit I, Etat_appareil E WHERE I.Utilisateur=E.utilisateur && E.Numero_appareil=$appareil;";
                $res5 = $pdo->prepare($info_user);
                $res5->execute();
                $colonne5 = $res5->fetch(PDO::FETCH_ASSOC);

                // requete pour eteindre
                $res6 = $pdo->prepare($sql_on_off);
                $res6->execute();
                // requete pour l'heure fin et totale
                $res7 = $pdo->prepare($sql_last_user);
                $res7->execute();
                $colonne7 = $res7->fetch(PDO::FETCH_ASSOC);
                // stockage les info dans une variable
                $nom = $colonne5["Nom"];
                $prenom = $colonne5["Prénom"];
                $numero_appareil = $appareil;
                $heure_debut = $colonne7["Heure_debut"];
                $heure_fin = $colonne7["Heure_fin"];
                $Duree_totale = $colonne7["Duree_totale"];

                //faire la requete pour inserer dans la table historique
                $sql_history = "INSERT INTO `Historique` (`Nom`, `Prenom`, `Numero_appareil`, `Heure_debut`, `Heure_fin`, `Duree_totale`, `Jour`) VALUES ('$nom', '$prenom', '$appareil', '$heure_debut', '$heure_fin', '$Duree_totale', '$jourfr')";
                $res8 = $pdo->prepare($sql_history);
                $res8->execute();

                //remmetre à zero le table etat de l'appareil
                $sql_reset = "UPDATE `Etat_appareil` SET `Heure_debut` = '0', `Heure_fin` = '0', `Duree_totale` = '0', `utilisateur` = 'personne' WHERE `Numero_appareil` = $appareil";
                $res9 = $pdo->prepare($sql_reset);
                $res9->execute();

                echo "../index.html?appareil=$appareil";
            } else {
                echo 2;
            }
        } else {
            echo 1;
        }
    }
}
