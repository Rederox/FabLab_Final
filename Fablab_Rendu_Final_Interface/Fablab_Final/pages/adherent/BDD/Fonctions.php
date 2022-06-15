<?php

require "connexion_base.php";

function UDPRequest($str)
{
  $ipServeurRaspberry = "192.168.3.60";
  $port = 25000;

  $sock = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);
  // https://stackoverflow.com/questions/6137823/fatal-error-call-to-undefined-function-socket-create
  socket_set_option($sock, SOL_SOCKET, SO_BROADCAST, 1);
  socket_set_option($sock, SOL_SOCKET, SO_RCVTIMEO, array("sec" => 20, "usec" => 0));

  $res = socket_sendto($sock, $str, strlen($str), 0, $ipServeurRaspberry, $port);
  if ($res == NULL) {
    return "false";
  }

  $ret = @socket_recvfrom($sock, $buf, 20, 0, $ipServeurRaspberry, $port);
  if ($ret == NULL) {
    return "false";
  }

  if ($ret != 0) {
    return $buf;
  }

  socket_close($sock);
}

function InsertDataInDB($pdo, $sql)
{
  try {
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->exec($sql);
  } catch (PDOException $e) {
    echo $sql . "<br>" . $e->getMessage();
  }
}

function FetchDB($db, $sql)
{
  $statement = $db->query($sql);
  $donnees = $statement->fetchAll(PDO::FETCH_ASSOC);
  return $donnees;
}

function execute($db, $sql)
{
  $res = $db->prepare($sql);
  $exec = $res->execute();
}

function DisplayTableDel($pdo)
{
  $sql = "SELECT * from inscrit";
  $donnees = FetchDB($pdo, $sql);
  echo '<br><br> <div class="table-responsive">';
  echo '<table class="table table-striped">';
  echo '<tr class="violet"><th>ID</th><th>Nom</th><th>Prénom</th><th>ID du Badge</th><th>Mot de passe</th><th>Utilisateur</th><th>Présence FABLAB</th><th></th><th></th><th></th></tr>';
  foreach ($donnees as $donnee) {
    echo '<tr>';
    echo '<td>' . $donnee['ID'] . '</td>';
    echo '<td>' . $donnee['Nom'] . '</td>';
    echo '<td>' . $donnee['Prénom'] . '</td>';
    echo '<td>' . $donnee['BadgeID'] . '</td>';
    echo '<td>' . $donnee['Mot_de_passe'] . '</td>';
    echo '<td>' . $donnee['Utilisateur'] . '</td>';
    echo '<td>' . $donnee['PresentAuFablab'] . '</td>';
    echo '<td><form method="post" id="editForm' . $donnee['ID'] . '"><i class="fas fa-edit violet"></i>
    <input type="text" name="idToEdit" class="hide" value="' . $donnee['ID'] . '">
    <input type="button" value="Modifier" onclick="editUser(' . $donnee['ID'] . ')" class="Button"></form></td>';
    echo '<td><a>&nbsp</a></td>';
    echo '<td><form method="post" id="delForm' . $donnee['ID'] . '"><i class="fa-solid fa-trash violet"></i>
    <input type="text" name="idToDelete" class="hide" value="' . $donnee['ID'] . '">
    <input type="button" value="Supprimer" onclick="delUser(' . $donnee['ID'] . ')" class="Button"></form></td>';
    echo '</tr>';
  }
  echo '</table> </div>';
}

function checkTagEdit($donnees, $badgeSaisi, $idToEdit)
{
  foreach ($donnees as $data) {
    if ($data['BadgeID'] == $badgeSaisi && $idToEdit != $data['ID']) {
      return 1;
    }
  }
  return 0;
}

function checkTagAdd($donnees, $badgeSaisi)
{
  foreach ($donnees as $data) {
    if ($data['BadgeID'] == $badgeSaisi) {
      return 1;
    }
  }
  return 0;
}
