<?php


require("../pages/tag_nfc/php/mysql-connexion/connexion.php");
$sql = "SELECT A.Nom_appareil,utilisateur,Heure_debut from Etat_appareil E,Appareil A WHERE A.Numero_appareil=E.Numero_appareil and Etat=\"allumer\"";
$sql2 = "SELECT COUNT(utilisateur) as nombre from Etat_appareil WHERE Etat=\"allumer\"";

$res2 = $pdo->prepare($sql2);
$res2->execute();
$nombre = $res2->fetch(PDO::FETCH_ASSOC);

if ($pdo) {
    $res = $pdo->prepare($sql);
    $res->execute();
    while ($colonne = $res->fetch(PDO::FETCH_ASSOC)) {
    if ($nombre["nombre"] == 0) {
        echo '<tr><td><h2>Aucun</td><td><h2>machine</td><td><h2>est allumée</td></tr>';
    }else {
      
      echo '
      <tr>
      <td>' . $colonne["Nom_appareil"] . '</td>
      <td>' . $colonne["utilisateur"] . '</td>
      <td class="text-success"> ' . $colonne["Heure_debut"] . '</td>  
      </tr>
      
      ';
    }
    }
}