<?php 
    include 'conn.php';
    
            $event = $_POST['event'];

            switch($event) {
                case "login":
                    $email = $_POST['email'];
                    $password = $_POST['password'];
                    $queryResult=$connect->query("SELECT * from tbl_useraccounts WHERE email='".$email."' and password='".$password."'");
                    $result=array();

                    while($fetchData= $queryResult->fetch_assoc()){
                        $result[] = $fetchData;
                    }
                    echo json_encode($result);
                    break;
                case "register":
                    $fullName = $_POST['name'];
                    $email = $_POST['email'];
                    $password = $_POST['password'];
                    $accountType = $_POST['accountType'];

                    $sql = "INSERT INTO tbl_useraccounts (fullName, email, password,accountType)
                            VALUES ('".$fullName."', '".$email."', '".$password."','".$accountType."')";
                    if ($connect->query($sql) === TRUE) {
                        echo "New record created successfully";
                    } else {
                        echo "Error: " . $sql . "<br>" . $connect->error;
                    }
                    
                break;
                case "search":
                    
                    $queryResult=$connect->query("SELECT * from tbl_useraccounts");
                    $result=array();

                    while($fetchData= $queryResult->fetch_assoc()){
                        $result[] = $fetchData;
                    }
                    echo json_encode($result);
                default:
                    # code...
                    break;
            }
                
            
        
?>