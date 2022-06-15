<?php

require("../../mysql-connexion/connexion.php");

if ($pdo) {

  $sql_url = "SELECT SUBSTRING(N.url,13) as url,A.Nom_appareil,A.Numero_appareil FROM NFC_Notices N, Appareil A WHERE A.Numero_appareil = N.Numero_appareil";
  $res = $pdo->prepare($sql_url);
  $res->execute();

  while ($colonne = $res->fetch(PDO::FETCH_ASSOC)) {
    $a = substr(str_shuffle(str_repeat("0123456789abcdefghijklmnopqrstuvwxyz", 5)), 0, 5);
    $b = substr(str_shuffle(str_repeat("0123456789abcdefghijklmnopqrstuvwxyz", 5)), 0, 5);

    echo "<tr>
<td>" . $colonne["Numero_appareil"] . "</td>
<td>" . $colonne["Nom_appareil"] . "</td>
<td>
  <div class=\"box\">
    <a class=\"mdi mdi-eye view\" href=\"#popup_" . $colonne["Numero_appareil"] . "\"></a>
  </div>
  <div id=\"popup_" . $colonne["Numero_appareil"] . "\" class=\"overlay\">
    <div class=\"popup\">
      <h2>" . $colonne["Nom_appareil"] . "</h2>
      <a href=\"" . "?" . $a . "=" . $b . "#\" class=\"cross\">&times;</a>
      <div class=\"container\">
        <iframe class=\"responsive-iframe\"
          src=\"../../.." . $colonne["url"] . "\"></iframe>
      </div>
    </div>
  </div>
</td>
<td><label><a href=\"../../.." . $colonne["url"] . "\" download
      class=\"mdi mdi-arrow-down-bold-circle view\"></a></label></td>
</tr>";
  }
}
