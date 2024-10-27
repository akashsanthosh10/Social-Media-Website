<?php
error_reporting(E_ALL); // Report all types of errors
ini_set('display_errors', 1); // Display errors on the page
session_start();
include 'db.php'; // Include your database connection file

if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit();
}

$user_id = $_SESSION['user_id'];

// Fetch friends list
$sql = "SELECT u.user_id, u.username, 
               CASE WHEN f.friend_id IS NOT NULL THEN 1 ELSE 0 END AS is_following 
        FROM users u 
        LEFT JOIN friends f ON u.user_id = f.friend_id AND f.user_id = ? 
        WHERE u.user_id != ?"; // Exclude the logged-in user

$stmt = $conn->prepare($sql);
$stmt->bind_param("ii", $user_id, $user_id);
$stmt->execute();
$result = $stmt->get_result();

$friends = [];
while ($row = $result->fetch_assoc()) {
    $friends[] = $row; // Add each friend to the array
}

$stmt->close();
$conn->close();

header('Content-Type: application/json');
echo json_encode($friends); // Return friends list as JSON
?>
