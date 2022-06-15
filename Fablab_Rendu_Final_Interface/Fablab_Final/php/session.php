<?php
session_start();
if (!isset($_SESSION["login"])) {
    header("location:pages/login/");
}

echo $_SESSION["login"];
