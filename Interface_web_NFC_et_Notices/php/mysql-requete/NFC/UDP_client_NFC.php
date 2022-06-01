<?php
require("../../mysql-connexion/connexion.php");

$appareil = $_POST["appareil_NFC"];
$choix = $_POST["choix"];




if ($appareil == "none") {
    
}else {
$sql_numero_appareil = "SELECT `Numero_appareil` FROM Appareil WHERE `Nom_appareil`='$appareil'";
if ($pdo) {
    $res =  $pdo->prepare($sql_numero_appareil);
    $res->execute();
    $colonne = $res->fetch(PDO::FETCH_ASSOC);
    $numero = $colonne["Numero_appareil"];
}

$sql_url = "SELECT url FROM `NFC_Notices` WHERE `Numero_appareil`=$numero";
$res = $pdo->prepare($sql_url);
$res->execute();
$colonne = $res->fetch(PDO::FETCH_ASSOC);

}


switch ($choix) {
    case '1':
        $msg = $choix . " " . $colonne["url"];
        break;

    case '2':
        $msg = $choix;
        break;

    case '3':
        $msg = $choix;
        break;

    case '4':
        $msg = $choix - 3 . " " . "192.168.3.83/Theivathan/Relay/index.html?appareil=$numero";
        break;
    default:

        break;
}

$server = '192.168.3.60';
$port = 26000;

$sock = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);

$len = strlen($msg);

socket_sendto($sock, $msg, $len, 0, $server, $port);

socket_recvfrom($sock, $buf, 1024, 0, $server, $port);
echo $buf;

socket_close($sock);
