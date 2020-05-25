<?php

$connect = new mysqli("localhost","root","","eventory");

if($connect){
	 
}else{
	echo "Fallo, revise ip o firewall";
	exit();
}