<?php

require 'variables.php';

$dsn = "mysql:host=$host;dbname=$db;charset=UTF8";

try {
	$pdo = new PDO($dsn,$user,$password);

	if ($pdo) {
		//echo "Connexion à $db réussi!";
	}
} catch (PDOException $e) {
	echo $e->getMessage();
}