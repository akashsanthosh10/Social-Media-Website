<?php
include 'db.php';
echo "Reached register.php";
ini_set('display_errors', 1);
error_reporting(E_ALL);

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $username = mysqli_real_escape_string($conn, $_POST['reg-username']);
    $email = mysqli_real_escape_string($conn, $_POST['reg-email']);
    $password = password_hash($_POST['reg-password'], PASSWORD_BCRYPT);

    // Ensure the SQL statement uses the correct column name
    $sql = "INSERT INTO users (username, email, new_password) VALUES ('$username', '$email', '$password')";
    
    if ($conn->query($sql) === TRUE) {
        echo "<script>
                alert('Registration successful! Please log in.');
                window.location.href = 'login.html'; // Redirect to the login page
              </script>";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>
