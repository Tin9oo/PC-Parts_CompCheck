<html>
<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");
    $sql_fk=" SET foreign_key_checks = 0;";
    mysqli_query($con,$sql_fk);
    $sql="INSERT INTO part(part_type, product_number, Name_of_product) VALUES ('";
    $sql.=$_GET['part_type'];
    $sql.="','";
    $sql.=$_GET['part_number'];
    $sql.="','";
    $sql.=$_GET['part_name'];
    $sql.="');";
    $ret=mysqli_query($con,$sql);


    $sql_field="DESC ";
    $sql_field.=$_GET['part_type'];
    $sql_field.=";";
    $ret_field=mysqli_query($con,$sql_field);

    $sql_insert="INSERT IGNORE ";
    $sql_insert.=$_GET['part_type'];
    $sql_insert.=" (";
    while ($row=mysqli_fetch_array($ret_field)) {
        $sql_insert.=$row['Field'];
        $sql_insert.=",";
    }
    $sql_insert=substr($sql_insert,0,-1);
    $sql_insert.=")";
    $sql_insert.=" VALUES ('";
    $ret_field=mysqli_query($con,$sql_field);
    while ($row=mysqli_fetch_array($ret_field)) {
        if($row['Type']=='int'||$row['Type']=='tinyint') $sql_insert=substr($sql_insert,0,-1);

        $sql_insert.=$_GET[$row['Field']];
    
        $sql_insert.="'";

        if($row['Type']=='int'||$row['Type']=='tinyint') $sql_insert=substr($sql_insert,0,-1);

        $sql_insert.=",'";
    }
    $sql_insert=substr($sql_insert,0,-2);
    $sql_insert.=");";
    // echo $sql_insert;
    $ret=mysqli_query($con,$sql_insert);

    $sql_fk=" SET foreign_key_checks = 1;";
    mysqli_query($con,$sql_fk);

    // $sql="DESC cpu";
    // $ret=mysqli_query($con,$sql);

    // $sql_proc="CALL add_new_cpu_proc('";
    // $sql_proc.=$_GET['cpu_part_type'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_part_name'];
    // $sql_proc.="','";
    // while ($row=mysqli_fetch_array($ret)) {
    //     //echo "<input type='text' name='",$part_type_array[$i],"_",$row['Field'],"' placeholder='",$row['Field'],"'> <br>";
    //     if($row['Type']=='int'||$row['Type']=='tinyint') $sql_proc=substr($sql_proc,0,-1);
    //     $tmp="cpu_";
    //     $tmp.=$row['Field'];
    //     $sql_proc.=$_GET[$tmp];
    //     $sql_proc.="'";

    //     if($row['Type']=='int'||$row['Type']=='tinyint') $sql_proc=substr($sql_proc,0,-1);

    //     $sql_proc.=",'";
    // }
    // // $sql_proc.=$_GET['cpu_generation'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_Socket'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_built_in_graphics_status'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_core'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_price'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_ram_generation'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_class'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_fabless'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_product_number'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_max_watt'];
    // // $sql_proc.="','";
    // // $sql_proc.=$_GET['cpu_ram_operating_speed'];
    // $sql_proc=substr($sql_proc,0,-2);
    // $sql_proc.=");";

    // // echo $sql_proc;
    
    // $ret=mysqli_query($con,$sql_proc);

    mysqli_close($con);
?>
    
    <form>
        <br><input type='submit' value='확인' formaction='add_new_product.php'/>
    </form>

</html>