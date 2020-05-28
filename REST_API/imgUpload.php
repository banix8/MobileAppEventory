<?php

	include 'conexion.php';
	
	$image = $_FILES['image']['name'];

	$imagePath = "C:/xampp/htdocs/eventory/uploads/".$image;
    move_uploaded_file($_FILES['image']['tmp_name'],$imagePath);
    
    	
	$connect->query("INSERT INTO tbl_supplier (image) VALUES ('".$image."')")

    ?>