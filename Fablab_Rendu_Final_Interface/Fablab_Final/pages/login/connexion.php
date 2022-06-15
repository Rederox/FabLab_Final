<?php
require("variables.php");

try {

    $pdo = new PDO($base, $user, $password);
} catch (PDOException $e) {
    printf("Échec de la connexion : %s\n", $e->getMessage());
    exit();
}
