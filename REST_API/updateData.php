<?php

	include 'conexion.php';
	
	$supplierPhone = $_POST['supplierPhone'];
	$supplierAddress = $_POST['supplierAddress'];
	$supplierRate = $_POST['supplierRate'];
    $supplierYears = $_POST['supplierYears'];
    $supplierBio = $_POST['supplierBio'];
	
	
	$connect->query("INSERT INTO tbl_supplier (supplierPhone,supplierAddress,supplierRate,supplierYears,supplierBio) VALUES ('".$supplierPhone."','".$supplierAddress."','".$supplierRate."','".$supplierYears."','".$supplierBio."')")

?>