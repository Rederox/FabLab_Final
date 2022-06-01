<?php

    require("../../mysql-connexion/connexion.php");
    
    $appareil = $_POST["appareil"];
    $type = $_POST["type"];

    $etat = "SELECT Etat FROM Etat_appareil where Numero_appareil = '$appareil' ";
    
    if ($pdo) {
        $res =  $pdo->prepare($etat);
        $res->execute();
        $colonne = $res->fetch(PDO::FETCH_ASSOC);

        if ($type == "number") {
            if ($colonne["Etat"] == "eteint"){
                echo 1;
            }else {
                echo 2;
            }
        }else{
            if ($colonne["Etat"] == "eteint"){
                echo "Allumer";
            }else{
                echo "Eteindre";
            }
        }
    }
    
?>  