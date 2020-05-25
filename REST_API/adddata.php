<?php

	include 'conexion.php';
	
	$fullName = $_POST['fullName'];
	$email = $_POST['email'];
	$password = $_POST['password'];
	$accountType = $_POST['accountType'];
	
	
	$connect->query("INSERT INTO tbl_useraccounts (fullName,email,password,accountType) VALUES ('".$fullName."','".$email."','".$password."','".$accountType."')")

?>