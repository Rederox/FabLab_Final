<?php


require("../pages/tag_nfc/php/mysql-connexion/connexion.php");
$sql = "SELECT Nom,Prénom,HeureEntree from inscrit where PresentAuFablab = 1 ";

$sql2 = "SELECT COUNT(ID) as nombre from inscrit WHERE PresentAuFablab = 1";




if ($pdo) {


  $res2 = $pdo2->prepare($sql2);
  $res2->execute();
  $nombre = $res2->fetch(PDO::FETCH_ASSOC);


  
    $res = $pdo->prepare($sql);
    $res->execute();
    while ($colonne = $res->fetch(PDO::FETCH_ASSOC)) {
    if ($colonne["Nom"] == 0) {
        //echo '<tr><td><h2>Le FabLab</td><td><h2>est vide</td><td><h2>pour l\'instant</td></tr>';
        echo 'otter';
    }else {
      
      echo '
      <tr>
      <td>' . $colonne["Nom"] . '</td>
      <td>' . $colonne["Prénom"] . '</td>
      <td class="text-success"> ' . $colonne["HeureEntree"] . '</td>  
      </tr>
      
      ';
    }
    }
}
