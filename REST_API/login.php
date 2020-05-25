<?php

    include 'conexion.php';
    if ( isset($_POST['email']) || isset($_POST['passwod']) ){
    $username = $_POST['email'];
    $password = $_POST['password'];

    $consultar=$connect->query("SELECT * FROM tbl_useraccounts WHERE email ='".$username."' and password='".$password."'");

    $resultado=array();

    while($extraerDatos=$consultar->fetch_assoc()){
        $resultado[]=$extraerDatos;
    }

    echo json_encode($resultado);


}

    ?>


    