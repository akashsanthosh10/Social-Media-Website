<?php

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "social_media_app"; // Change to your database name

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
