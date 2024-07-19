<?php

session_start();
include "../Utils/Validation.php";
include "../Utils/Util.php";
include "../Database.php";
include "../Models/User.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $user_name = Validation::clean($_POST["username"]);
    $password = Validation::clean($_POST["password"]);
    
    if (!Validation::username($user_name)) {
        $em = "Invalid user name";
        Util::redirect("../login.php", "error", $em);
    } else if (!Validation::password($password)) {
        $em = "Invalid Password";
        Util::redirect("../login.php", "error", $em);
    } else {
        $db = new Database();
        $conn = $db->connect();
        $user = new User($conn);
        $auth = $user->auth($user_name, $password);
        
        if ($auth) {
            $user_data = $user->getUser();
            $_SESSION['user_name'] = $user_data['user_name'];
            $_SESSION['user_id'] = $user_data['user_id'];
            $sm = "logged in!";
            
            
            if (isset($_POST['remember_me']) && $_POST['remember_me'] == 'on') {
                // Set cookie to remember user
                $cookie_name = "remember_me_cookie";
                $cookie_value = base64_encode($_SESSION['user_id']);
                setcookie($cookie_name, $cookie_value, time() + (86400 * 30), "/"); // 30 days expiration
            }
            
            Util::redirect("../index.php", "success", $sm);
        } else {
            $em = "Incorrect username or password";
            Util::redirect("../login.php", "error", $em);
        }
    }

} else {
    $em = "An error occurred";
    Util::redirect("../login.php", "error", $em);
}


// if ($_SERVER['REQUEST_METHOD'] == "POST") {
// 	$user_name = Validation::clean($_POST["username"]);
// 	$password = Validation::clean($_POST["password"]);
    
//     if (!Validation::username($user_name)) {
//     	$em = "Invalid user name";
// 	    Util::redirect("../login.php", "error", $em);
//     }else if(!Validation::password($password)){
//     	$em = "Invalid Password";
// 	    Util::redirect("../login.php", "error", $em);
//     }else {
//        $db = new Database();
//        $conn = $db->connect();
//        $user = new User($conn);
//        $auth = $user->auth($user_name, $password);
//        if ($auth) {
//        	$user_data = $user->getUser();
//          $_SESSION['user_name'] = $user_data['user_name'];
//          $_SESSION['user_id'] = $user_data['user_id'];
//          $sm = "logged in!";
//          Util::redirect("../index.php", "success", $sm);
//        }else {
//           $em = "Incorrect username or password";
// 	       Util::redirect("../login.php", "error", $em);
//        }
       
//     }

// }else {
// 	$em = "An error occurred";
// 	Util::redirect("../login.php", "error", $em);
// }