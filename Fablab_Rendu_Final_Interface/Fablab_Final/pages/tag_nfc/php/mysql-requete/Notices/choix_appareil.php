<?php

require("../../mysql-connexion/connexion.php");

$sql = "SELECT Numero_appareil,Nom_appareil FROM `Appareil`";
if ($pdo) {
    $res =  $pdo->prepare($sql);
    $res->execute();
    echo '<option value="0"></option>';
    while ($colonne = $res->fetch(PDO::FETCH_ASSOC)) {
        echo '<option value="' . $colonne['Nom_appareil'] . '">' . $colonne['Nom_appareil'] . '</option>';
    }
}
