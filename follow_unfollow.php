<?php
session_start();
include 'db.php';
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

if (!isset($_SESSION['user_id'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'User not logged in.']);
    exit();
}

$user_id = $_SESSION['user_id'];
$data = json_decode(file_get_contents('php://input'), true); // Get the JSON payload

if (!isset($data['userId']) || !isset($data['action'])) {
    header('Content-Type: application/json');
    echo json_encode(['success' => false, 'message' => 'Invalid input.']);
    exit();
}

$friend_id = (int)$data['userId'];
$action = $data['action'];

if ($action === 'follow') {
    // Insert a new follow relationship into the friends table
    $sql = "INSERT INTO friends (user_id, friend_id) VALUES (?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $user_id, $friend_id);
    $success = $stmt->execute();
    $stmt->close();
} elseif ($action === 'unfollow') {
    // Delete the follow relationship from the friends table
    $sql = "DELETE FROM friends WHERE user_id = ? AND friend_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("ii", $user_id, $friend_id);
    $success = $stmt->execute();
    $stmt->close();
} else {
    $success = false;
}

$conn->close();

header('Content-Type: application/json');
echo json_encode(['success' => $success]);
?>
