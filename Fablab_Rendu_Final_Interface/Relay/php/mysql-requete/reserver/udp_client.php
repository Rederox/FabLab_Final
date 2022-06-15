<?php
require("../../mysql-connexion/connexion.php");


$etat = $_POST["etat"];
$appareil = $_POST["appareil"];

$sql_port_appareil = "SELECT port FROM `Appareil` WHERE Numero_appareil = $appareil;";
$res = $pdo->prepare($sql_port_appareil);
$res->execute();
$colonne = $res->fetch(PDO::FETCH_ASSOC);

$sortie_appareil = $colonne["port"];


$msg = sprintf("%d %d", $sortie_appareil, $etat);;
$server = '192.168.3.56';
$port = 26000;

$sock = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);

$len = strlen($msg);

socket_sendto($sock, $msg, $len, 0, $server, $port);

//socket_recvfrom($sock, $buf, 1024, 0, $server, $port);
// echo $buf;

socket_close($sock);
