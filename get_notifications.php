<?php
session_start();
include 'db.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);


if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}

$user_id = $_SESSION['user_id'];

// Fetch notifications for the logged-in user
$sql = "SELECT message FROM notifications WHERE user_id = '$user_id'";
$stmt = $conn->prepare($sql);
$stmt->execute();
$result = $stmt->get_result();

$notifications = [];
while ($row = $result->fetch_assoc()) {
    $notifications[] = $row['message'];
}

$stmt->close();
$conn->close();

header('Content-Type: application/json');
echo json_encode($notifications);
?>
