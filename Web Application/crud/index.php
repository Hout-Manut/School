<?php
require_once 'db.php';

$database = new Database();
$users = $database->getAllUsers();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
</head>
<body>
    <h2>Users</h2>
    <ul>
        <?php foreach ($users as $user) : ?>
            <li><?= $user['name']; ?> | <a href="edit.php?id=<?= $user['id']; ?>">Edit</a> | <a href="delete.php?id=<?= $user['id']; ?>">Delete</a></li>
        <?php endforeach; ?>
    </ul>
    <a href="add.php">Add user</a>
</body>
</html>