<?php
     $conn=mysqli_connect("localhost","root","5964","mydb") or die("MySQL 접속 실패 !!");
     $sql_fk=" SET foreign_key_checks = 0;";
     $ret_fk=mysqli_query($conn,$sql_fk);
    $sql="DELETE  FROM pocket WHERE (product_number='{$_GET['product_number']}')and (ID='{$_GET['user_id']}');";
   
    //  $sql.="$_GET['product_number']";
    //  $sql.="')";
    $sql_fk=" SET foreign_key_checks = 1;";
    $ret=mysqli_query($conn,$sql);
    $ret_fk=mysqli_query($conn,$sql_fk);
    if ($conn->query($sql) === TRUE) {
        echo "부품이 성공적으로 제거되었습니다.";
      } else {
        echo "삭제 오류: " . $conn->error;
      }
    echo "<form action='part_cpu_joo.php'>";
    echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";
    echo "<input type='hidden' name='type' value='",$_GET['type'],"'>";
    echo "<input type='submit' value='확인'>";
    echo "</form>";

    mysqli_close($conn);
?>