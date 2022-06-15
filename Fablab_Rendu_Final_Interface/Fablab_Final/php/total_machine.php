<?php

require("../pages/tag_nfc/php/mysql-connexion/connexion.php");
$sql = "SELECT COUNT(id)  as total FROM `Appareil` ";

if ($pdo) {
    $res = $pdo->prepare($sql);
    $res->execute();
    $colonne = $res->fetch(PDO::FETCH_ASSOC);
}

echo "<p class=\"fs-30 mb-2\">" . $colonne["total"] . " machines</p>";
