<?php
session_start();
include "Utils/Util.php";
include "Database.php";
include "Models/User.php";

// include "_autoload.php";

// Check if user is logged in
if (!isset($_SESSION['user_name']) || !isset($_SESSION['user_id'])) {
    $em = "Please log in first.";
    Util::redirect("login.php", "error", $em);
}

$db = new Database();
$conn = $db->connect();
$user = new User($conn);

// Fetch all users
$all_users = $user->getAllUsers(); // Implement this method in your User class

?>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>All Users</title>
    <link rel="stylesheet" type="text/css" href="Assets/css/style.css">
</head>
<body>
    <div class="wrapper">
        <div class="form-holder">
            <h2>All Users</h2>
            <table>
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>User Name</th>
                        <th>Full Name</th>
                        <th>Email</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($all_users as $u) : ?>
                        <tr>
                            <td><?= $u['user_id'] ?></td>
                            <td><?= $u['user_name'] ?></td>
                            <td><?= $u['user_full_name'] ?></td>
                            <td><?= $u['user_email'] ?></td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
            <div class="form-group">
                <a href="index.php" class="button">Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html>
