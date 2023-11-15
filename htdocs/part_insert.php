<?php
    $con=mysqli_connect("localhost","root","5964","mydb") or die("MySQL 접속 실패 !!");
    

    $sql="INSERT INTO pocket(Type,quantity,ID,product_number) VALUES ('{$_GET['type']}',1,'";
    $sql.=$_GET['user_id'];
    $sql.="','";
    $sql.=$_GET['product_number'];
    $sql.="') ON DUPLICATE KEY UPDATE quantity = quantity + 1;";
    // $sql="CALL insert_cpu()";
    // echo $sql;
    $ret=mysqli_query($con,$sql);

    echo "<form action='part_cpu_joo.php'>";
    echo "<input type='hidden' name='type' value='",$_GET['type'],"'>";
    echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";
    echo "<input type='submit' value='확인'>";
    echo "</form>";

    mysqli_close($con);
?>