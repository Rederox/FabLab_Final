<?php

    require("../../mysql-connexion/connexion.php");
    
    $appareil = $_POST["appareil"];
    $etat = "SELECT Nom_appareil FROM Appareil where Numero_appareil = '$appareil' ";
    
    if ($pdo) {
        $res =  $pdo->prepare($etat);
        $res->execute();
        $colonne = $res->fetch(PDO::FETCH_ASSOC);
        echo "Appareil choisi est : <a class='machine'>".$colonne["Nom_appareil"]."</a>";
    }
    
?>