<?php
require "BDD/connexion_base.php";
require "BDD/Fonctions.php";

$donnees = FetchDB($pdo,"SELECT * from inscrit");
$idToEditJS =($_GET['id']-1);
$idToEdit =$_GET['id'];
$nomDejaPresent = $donnees[$idToEditJS]['Nom'];
$prenomDejaPresent = $donnees[$idToEditJS]['Prénom'];
$mdpDejaPresent = $donnees[$idToEditJS]['Mot_de_passe'];
$badgeIdDejaPresent = $donnees[$idToEditJS]['BadgeID'];

echo '<script type="text/javascript">showPreviousData('.$idToEditJS.',"'.$nomDejaPresent.'","'.$prenomDejaPresent.'","'.$mdpDejaPresent.'");</script>'; 
if(isset($_POST['nom']) && isset($_POST['prenom']) && isset($_POST['choix']) && isset($_POST['choix'])){

    $mdp=$_POST['password']; 
    $prenom=$_POST['prenom']; 
    $nom=$_POST['nom']; 
    $choix=$_POST['choix'];
    if($choix == 1){   
        $answer = UDPRequest("test");
        if($answer == "true"){
            $badgeID = UDPRequest("badgeRequest");
            if($badgeID =="noTag"){
                echo '<script>noTagPresent(); </script>';
            }else{
                $sameIDAnswer = checkTagAdd($donnees,$badgeID);
                if($sameIDAnswer == 0){
                    if($nom != $nomDejaPresent or $prenom != $prenomDejaPresent or $badgeID != $badgeIdDejaPresent or $mdp != $mdpDejaPresent){
                        InsertDataInDB($pdo,"UPDATE inscrit SET Nom = '$nom', Prénom = '$prenom', BadgeID = '$badgeID', Mot_de_passe = '$mdp', Utilisateur = '$prenom' WHERE ID = $idToEdit;");
                        echo '<script>edited();
                        console.log("hideTag");</script>';
                    }else{
                        echo '<script>hideLoadingTag();';
                        
                       echo' nothingChanged('.$idToEdit.'); 
                        console.log("hideTag");</script>';
                    }
                }else{
                    echo '<script type="text/javascript">tagAlreadyUsedEdit('.$idToEdit.');</script>';
                }
            }
        }else{
            echo '<script type="text/javascript">readerCantBeReached();</script>';
        }
    }elseif($choix == 2){
        $badgeID = $_POST['badge'];
        $sameIDAnswer = checkTagEdit($donnees,$badgeID,$idToEdit);
        if($sameIDAnswer == 0){
            if($nom != $nomDejaPresent or $prenom != $prenomDejaPresent or $badgeID != $badgeIdDejaPresent or $mdp != $mdpDejaPresent){
                InsertDataInDB($pdo,"UPDATE inscrit SET Nom = '$nom', Prénom = '$prenom', BadgeID = '$badgeID', Mot_de_passe = '$mdp', Utilisateur = '$prenom' WHERE ID = $idToEdit;");
                echo '<script> edited(); </script>';
            }else{
                echo '<script> nothingChanged('.$idToEdit.'); </script>';
            }
        }else{
            echo '<script type="text/javascript">tagAlreadyUsedEdit('.$idToEdit.');</script>';
        }
    }
    unset($prenom);
    unset($nom);
    unset($badgeID);
    unset($mdp);
}

?>