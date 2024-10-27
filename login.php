<?php
session_start();
include 'db.php';
echo "Reached login.php";
ini_set('display_errors', 1);
error_reporting(E_ALL);

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get login form data
    $email = mysqli_real_escape_string($conn, $_POST['email']);
    $password = $_POST['password'];

    // Query the database for the user
    $sql = "SELECT * FROM users WHERE email = '$email'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Fetch the user record
        $user = $result->fetch_assoc();
        $hashedPassword = $user['new_password']; // Correct field name from the database

        // Verify the password
        if (password_verify($password, $hashedPassword)) {
            // Password is correct, start a session
            $_SESSION['user_id'] = $user['user_id'];
            $_SESSION['username'] = $user['username'];

            // Redirect to a protected page or homepage
            header("Location: index.html");
            exit();
        } else {
            // Password is incorrect
            echo "Incorrect password. Please try again.";
        }
    } else {
        // No user found with that email
        echo "No account found with that email address.";
    }
}

$conn->close();
?>
