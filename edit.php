<?php
session_start();
include 'db.php';
echo "Reached edit.php";

// Check if user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.html");
    exit(); // Stop further execution if the user is not logged in
}
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $user_id = $_SESSION['user_id']; // Assuming user_id is stored in session
    $name = mysqli_real_escape_string($conn, $_POST['name']);
    $bio = mysqli_real_escape_string($conn, $_POST['bio']);
    $phone = mysqli_real_escape_string($conn, $_POST['phone']);
    $website = mysqli_real_escape_string($conn, $_POST['website']);
    echo "$user_id";
    $sql = "UPDATE users SET username='$name', bio='$bio', phone='$phone', website='$website' WHERE user_id='$user_id'";

    if ($conn->query($sql) === TRUE) {
        // Redirect or provide feedback
        echo "<script>alert('Profile updated successfully!'); window.location.href='index.html';</script>";
    } else {
        echo "Error updating profile: " . $conn->error;
    }
}

$conn->close();
?>
