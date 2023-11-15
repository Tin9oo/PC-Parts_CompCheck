<html>
<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

    // $sql="INSERT INTO part(part_type, product_number, Name_of_product) VALUES ('";
    // $sql.=$_GET['cpu_part_type'];
    // $sql.="','";
    // $sql.=$_GET['cpu_part_number'];
    // $sql.="','";
    // $sql.=$_GET['cpu_part_name'];
    // $sql.="');";
    // $ret=mysqli_query($con,$sql);


    // $sql="DESC cpu;";
    // $ret=mysqli_query($con,$sql);
    // $sql="INSERT INTO cpu(generation,Socket,Built_in_graphics_status,Core,Price,RAM_generation,Class,Fabless,product_number,Max_watt,Ram_operating_speed) VALUES ('";
    // while ($row=mysqli_fetch_array($ret)) {
    //     if($row['Type']=='int'||$row['Type']=='tinyint') $sql=substr($sql,0,-1);

    //     $tmp="cpu_";
    //     $tmp.=$row['Field'];
    //     $sql.=$_GET[$tmp];
    
    //     $sql.="'";

    //     if($row['Type']=='int'||$row['Type']=='tinyint') $sql=substr($sql,0,-1);

    //     $sql.=",'";
    // }
    // $sql=substr($sql,0,-2);
    // $sql.=");";
    // echo $sql;
    // $ret=mysqli_query($con,$sql);

    $sql="DESC cpu";
    $ret=mysqli_query($con,$sql);

    $sql_proc="CALL add_new_cpu_proc('";
    $sql_proc.=$_GET['cpu_part_type'];
    $sql_proc.="','";
    $sql_proc.=$_GET['cpu_part_name'];
    $sql_proc.="','";
    while ($row=mysqli_fetch_array($ret)) {
        //echo "<input type='text' name='",$part_type_array[$i],"_",$row['Field'],"' placeholder='",$row['Field'],"'> <br>";
        if($row['Type']=='int'||$row['Type']=='tinyint') $sql_proc=substr($sql_proc,0,-1);
        $tmp="cpu_";
        $tmp.=$row['Field'];
        $sql_proc.=$_GET[$tmp];
        $sql_proc.="'";

        if($row['Type']=='int'||$row['Type']=='tinyint') $sql_proc=substr($sql_proc,0,-1);

        $sql_proc.=",'";
    }
    // $sql_proc.=$_GET['cpu_generation'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_Socket'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_built_in_graphics_status'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_core'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_price'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_ram_generation'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_class'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_fabless'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_product_number'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_max_watt'];
    // $sql_proc.="','";
    // $sql_proc.=$_GET['cpu_ram_operating_speed'];
    $sql_proc=substr($sql_proc,0,-2);
    $sql_proc.=");";

    // echo $sql_proc;
    
    $ret=mysqli_query($con,$sql_proc);

    mysqli_close($con);
?>
    
    <form>
        <br><input type='submit' value='확인' formaction='add_new_product.php'/>
    </form>

</html>