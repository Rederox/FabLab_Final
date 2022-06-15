<?php

require "../BDD/connexion_base.php";
require "../BDD/Fonctions.php";

$idToEdit = ($_POST['id']-1);
$donnees = FetchDB($pdo,"SELECT * FROM inscrit;");
$badgeID = $donnees[$idToEdit]['BadgeID'];
echo json_encode(array('badgeID' => $badgeID));
?>