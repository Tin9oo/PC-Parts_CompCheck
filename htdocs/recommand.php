<?php
    $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

    $sql_proc="CALL recommand_all_proc('";
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

    echo "<h1> Recommand Combination List </h1>";
    echo "<h5> 선택하신 사양에서 추천드릴 수 있는 조합입니다. </h5><br>";

    $prod_type=array("cpu","gpu","ram","ssd");
    $i=0;
    $r_num=1;
    while($row=mysqli_fetch_array($ret)) {
        if ($i==0) {
            echo "<hr><form method='get' action='recommand_branch.php'>";
            echo "<input type='hidden' name=user_id value=", $_GET["user_id"], ">";
        }
        
        echo $row["rcm_num"],"번째 추천 ",$row["product_number"],"<br>";
        echo "<input type='hidden' name=",$prod_type[$i]," value=",$row["product_number"], ">";

        if ($i==3) {
            echo "<hr><input type='submit' value='선택'/>";
            //echo "<hr><a href='recommand_branch.php?user_id=",$_GET["user_id"],"&rcm_num=",$r_num,"'>선택</a><br>";
            $r_num++;
        }
        if ($i==3) echo "</form><br>";

        $i++;
        if($i==4) $i=0;
    }

    echo "<br>";
    echo "<input type='button' value='이전' onClick='history.go(-1)'>";
    // echo "<a href='recommand_choice_spec.php?user_id=", $_GET["user_id"], "'>이전 화면으로 이동..</a> <br>";
    echo "<a href='main.html'> 로그인 화면으로 이동.. </a>";

    mysqli_close($con);
?>