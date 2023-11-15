<?php
    $con=mysqli_connect("localhost", "root", "****", "mydb") or die("MySQL 접속 실패 !!");
    
    print_r($_POST);

    mysqli_close($con);
?>