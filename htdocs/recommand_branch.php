<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

    $sql_proc="CALL rcm_insert('";
    $sql_proc.=$_GET['cpu'];
    $sql_proc.="','";
    $sql_proc.=$_GET['gpu'];
    $sql_proc.="','";
    $sql_proc.=$_GET['ram'];
    $sql_proc.="','";
    $sql_proc.=$_GET['ssd'];
    $sql_proc.="','";
    $sql_proc.=$_GET['user_id'];
    $sql_proc.="');";
    
    $ret=mysqli_query($con, $sql_proc);

    echo "<h1> 현재 선택 조합 </h1>";
    echo "<h5> 현재 선택하신 조합에 해당하는 부품입니다. <br>
        바로 호환성 검사를 진행하시거나 상세 부품을 직접 선택하실 수 있습니다.
        </h5><br>";

    echo "<hr><form method='get'>";
    echo "<input type='hidden' name=user_id value=", $_GET["user_id"], ">";
    echo "<input type='hidden' name=type value='cpu'>";

    $prod_type=array("cpu","gpu","ram","ssd","mainboard","pc_case","power","cooler");
    $i=0;
    while($row=mysqli_fetch_array($ret)) {
        echo $prod_type[$i]," : ",$row["Name_of_product"],"<br>";
        $i++;
    }
    echo "<hr><input type='submit' value='상세 선택' formaction='part_cpu_joo.php'/>&emsp;&emsp;";
    echo "<input type='submit' value='호환성 검사' formaction='compatibility_check.php'/>";
    echo "</form><br>";

    echo "<br>";
    echo "<input type='button' value='이전' onClick='history.go(-1)'>";
    // echo "<a href='recommand.php?user_id=", $_GET["user_id"], "'>이전 화면으로 이동..</a> <br>";
    echo "<a href='main.html'> 로그인 화면으로 이동.. </a>";

    mysqli_close($con);
?>