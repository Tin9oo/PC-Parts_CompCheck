<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

    $sql_proc="CALL comp_chk_proc('";
    $sql_proc.=$_GET['user_id'];
    $sql_proc.="');";
    
    $ret=mysqli_query($con, $sql_proc);

    echo "<h1>호환성 검사 결과</h1>";
    // echo "<h5>선택하신 부품</h5>";

    echo "<hr><form method='get' action='recommand_branch.php'>";
    echo "<input type='hidden' name=user_id value=", $_GET["user_id"], ">";
    echo "<input type='hidden' name=type value='cpu'>";

    $stat=0;
    $i=0;
    while($row=mysqli_fetch_array($ret)) {
        if ($row['stat']==1) {
            echo $row["comp_error_mesg"],"<br>";
            $stat=$row['stat'];
            $i++;
        }
        else if ($row['stat']==3) {
            echo $row["not_good"],"<br>";
            $stat=$row['stat'];
            $i++;
        }
    }
    if ($i==0) echo "호환성에 이상이 없습니다.";
    else if ($stat==3) echo "하지만, 호환성에는 이상이 없습니다.";

    echo "<br><br>";
    // echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "'>현재 부품에서 수정</a>&emsp;&emsp;";
    echo "<input type='submit' value='현재 부품에서 수정' formaction='part_cpu_joo.php'>&emsp;&emsp;";
    echo "</form>";
    // echo "<a href='select_service.php?user_id=", $_GET["user_id"], "'>새로운 서비스</a><br><br>";
    // echo "<a href='recommand.php?user_id=", $_GET["user_id"], "'>이전 화면으로 이동..</a> <br>";
    echo "<a href='main.html'> 로그인 화면으로 이동.. </a>";

    mysqli_close($con);
?>