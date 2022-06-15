<?php
require "BDD/connexion_base.php";
require "BDD/Fonctions.php";

if(isset($_POST['idToDelete'])){
    $id = $_POST['idToDelete'];
    execute($pdo, "DELETE FROM inscrit WHERE ID='$id'");
    
    FetchDB($pdo,"SET @count = 0;UPDATE `inscrit` SET `inscrit`.`ID` = @count:= @count + 1;");
    $donnees = FetchDB($pdo, "SELECT MAX(`ID`) FROM inscrit");
    $maxID = $donnees['0']['MAX(`ID`)'];
    echo 'max : '.$maxID;
  if($maxID !=NULL){
    execute($pdo,"ALTER TABLE inscrit AUTO_INCREMENT = $maxID;");
  }else{
    execute($pdo,"ALTER TABLE inscrit AUTO_INCREMENT = 0;");
  }
    echo"<script>deleted();</script>";
    unset($id);
}

?>