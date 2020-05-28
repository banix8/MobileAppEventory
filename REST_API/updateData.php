<?php

	include 'conexion.php';
	
	$image = $_FILES['image']['name'];

	$imagePath = "C:/xampp/htdocs/eventory/uploads/".$image;
	move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);

	$supplierPhone = $_POST['supplierPhone'];
	$supplierAddress = $_POST['supplierAddress'];
	$supplierRate = $_POST['supplierRate'];
    $supplierYears = $_POST['supplierYears'];
    $supplierBio = $_POST['supplierBio'];
	
	
	$connect->query("INSERT INTO tbl_supplier (image,supplierPhone,supplierAddress,supplierRate,supplierYears,supplierBio) VALUES ('".$image."','".$supplierPhone."','".$supplierAddress."','".$supplierRate."','".$supplierYears."','".$supplierBio."')")

?>