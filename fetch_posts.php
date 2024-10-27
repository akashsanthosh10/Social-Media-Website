<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);
session_start();
include 'db.php';

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

// Get the user ID from the session
$user_id = $_SESSION['user_id'];

// Prepare the SQL statement to fetch posts for the logged-in user
$sql = "SELECT p.content, p.created_at, u.username 
        FROM posts p 
        JOIN users u ON p.user_id = u.user_id 
        WHERE p.user_id = ? 
        ORDER BY p.created_at DESC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $user_id);
$stmt->execute();

$result = $stmt->get_result();
$posts = [];

// Fetch the posts into an array
while ($row = $result->fetch_assoc()) {
    $posts[] = $row;
}

// Close the connection and output the results
$stmt->close();
$conn->close();
header('Content-Type: application/json');
echo json_encode($posts);
?>
