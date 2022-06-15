<?php
require "BDD/connexion_base.php";
require "BDD/Fonctions.php";

if(isset($_POST['nom']) && isset($_POST['prenom']) && isset($_POST['choix']) && isset($_POST['choix'])){

    $donnees = FetchDB($pdo,"SELECT * from inscrit");
    $mdp=$_POST['password']; 
    $prenom=$_POST['prenom']; 
    $nom=$_POST['nom']; 
    $choix=$_POST['choix'];

    if($choix == 1){   
        $answer = UDPRequest("test");   //Envoi requête "test"
        if($answer == "true"){  // Si message reçu est "true"
            $badgeID = UDPRequest("badgeRequest");  //Demande de détection du badge
            if($badgeID =="noTag"){    //si aucun tag n'a été présenté
                echo '<script> noTagPresent(); </script>';
            }else{
                $sameIDAnswer = checkTagAdd($donnees,$badgeID); //on vérifie si le badge n'est pas déjà utilisé
                if($sameIDAnswer == 0){
                    //ajout des données dans la table inscrit
                InsertDataInDB($pdo,"INSERT INTO inscrit (Nom, Prénom, BadgeID, Utilisateur, Mot_de_passe, PresentAuFablab) VALUES ('$nom', '$prenom', '$badgeID','$prenom', '$mdp','0')");
                echo '<script> added(); </script>';
                }else{
                echo '<script type="text/javascript">tagAlreadyUsedAdd();</script>';
                }
            }
        }else{
            echo '<script type="text/javascript">readerCantBeReached();</script>';  
        }
    }elseif($choix == 2){
        $badgeID = $_POST['badge'];
        $sameIDAnswer = checkTagAdd($donnees,$badgeID);
        if($sameIDAnswer == 0){
        InsertDataInDB($pdo,"INSERT INTO inscrit (Nom, Prénom, BadgeID, Utilisateur, Mot_de_passe, PresentAuFablab) VALUES ('$nom', '$prenom', '$badgeID','$prenom', '$mdp','0')");
        echo '<script> added(); </script>';
        }else{
            echo '<script type="text/javascript">tagAlreadyUsedAdd();</script>';
        }
    }
    unset($prenom);
    unset($nom);
    unset($badgeID);
    unset($mdp);
}

?>