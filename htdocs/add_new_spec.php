<html>
<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

    $sql_proc="INSERT IGNORE spec (Part_type,specName,RnC,specCompatibility) VALUES ('";
    $sql_proc.=$_GET['spec_type'];
    $sql_proc.="','";
    $sql_proc.=$_GET['spec_name'];
    $sql_proc.="','";
    $sql_proc.=$_GET['spec_rnc'];
    $sql_proc.="','";
    $sql_proc.=$_GET['spec_comp'];
    $sql_proc.="');";
    // echo $sql_proc;

    // echo $sql_proc;
    
    $ret=mysqli_query($con,$sql_proc);

    mysqli_close($con);
?>
    
    <form>
        <br><input type='submit' value='확인' formaction='add_new_product.php'/>
    </form>

</html>