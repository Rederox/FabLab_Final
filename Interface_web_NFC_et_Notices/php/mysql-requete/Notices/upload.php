<?php
require("../../mysql-connexion/connexion.php");

if ($_POST['appareil'] != '') {
    if ($_FILES['file']['name'] != '') {
        $appareil = $_POST['appareil'];
        $fileName  =  $_FILES['file']['name'];
        $tempPath  =  $_FILES['file']['tmp_name'];
        $fileSize  =  $_FILES['file']['size'];

        $fileExt = strtolower(pathinfo($fileName, PATHINFO_EXTENSION));
        $upload_path = '/../../../../Notices/';
        $valid_extensions = array('pdf');

        $sql_numero_appareil = "SELECT `Numero_appareil` FROM Appareil WHERE `Nom_appareil`='$appareil'";
        //$sql_insert = "INSERT INTO `NFC_Notices` (`id`, `Numero_appareil`, `url`) VALUES (NULL, '1', 'test')";

        if ($pdo) {
            $res =  $pdo->prepare($sql_numero_appareil);
            $res->execute();
            $colonne = $res->fetch(PDO::FETCH_ASSOC);
            $numero = $colonne["Numero_appareil"];
        }
        $sql_insert = "INSERT INTO `NFC_Notices` (`Numero_appareil`, `url`) VALUES ('$numero' , \"192.168.3.83\/Theivathan\/Notices\/$appareil.pdf\")";
        if (!file_exists(__DIR__ . $upload_path . $appareil . "." . $fileExt)) {
            if (in_array($fileExt, $valid_extensions)) {

                if ($fileSize < 150000000) {
                    // move_uploaded_file($tempPath, $upload_path . $fileName);

                    if (move_uploaded_file($tempPath, __DIR__ .$upload_path . $appareil . "." . $fileExt)) {

                        if ($pdo) {
                            $res =  $pdo->prepare($sql_insert);
                            $res->execute();
                            echo "Fichier est télecharger";
                        }
                    } else {
                        echo "NON Reussi :(";
                    }
                } else {
                    echo "Desolé, Votre fichier depasse les 150mo";
                }
            } else {
                $errorMsg = "Seule les fichiers PDF sont autorisé";
                echo $errorMsg;
            }
        } else {
            if (move_uploaded_file($tempPath, __DIR__ . $upload_path . $appareil . "." . $fileExt)) {
                echo "Votre fichier est modifier";
            } else {
                echo "NON Reussi :(";
            }
        }
    } else {
        echo "Choisir un fichier";
    }
} else {
    echo "Veilleuz choisir l'Appareil";
}
