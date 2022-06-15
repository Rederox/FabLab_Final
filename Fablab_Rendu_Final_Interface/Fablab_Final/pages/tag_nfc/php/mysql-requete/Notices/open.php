<?php

require("../../mysql-connexion/connexion.php");
$sql_appareil = "SELECT \* FROM Appareil";


if ($pdo) {

    $sql_url = "SELECT SUBSTRING(N.url,13,40) as url,A.Nom_appareil FROM NFC_Notices N, Appareil A WHERE N.Numero_appareil=A.Numero_appareil";
    $res = $pdo->prepare($sql_url);
    $res->execute();

    while ($colonne = $res->fetch(PDO::FETCH_ASSOC)) {
        echo '<a href="' . $colonne["url"] . '">' . $colonne["Nom_appareil"] . '</a> <br>';
    }
}
