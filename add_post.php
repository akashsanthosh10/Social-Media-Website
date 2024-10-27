<?php
session_start();
include 'db.php'; // Include your database connection

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit();
}

// Get user ID from session
$user_id = $_SESSION['user_id'];

// Get post content from the request
$content = trim($_POST['content']); // Assuming 'content' is the name of the textarea

// Validate input
if (empty($content)) {
    echo json_encode(['success' => false, 'message' => 'Post content cannot be empty.']);
    exit();
}

// Prepare SQL statement to insert a new post
$sql = "INSERT INTO posts (user_id, content, created_at) VALUES (?, ?, NOW())";
$stmt = $conn->prepare($sql);
$stmt->bind_param("is", $user_id, $content);

if ($stmt->execute()) {
    echo json_encode(['success' => true, 'message' => 'Post added successfully.']);
} else {
    echo json_encode(['success' => false, 'message' => 'Error adding post.']);
}

// Close the statement and connection
$stmt->close();
$conn->close();
?>
