<?php
include 'conexion.php';

$queryResult=$connect->query("SELECT supplierPhone, supplierAddress, supplierRate,supplierYears, supplierBio FROM tbl_supplier");

$result=array();

while($fetchData=$queryResult->fetch_assoc()){
	$result[]=$fetchData;
}

echo json_encode($result);

?>
