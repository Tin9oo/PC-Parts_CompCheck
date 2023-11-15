<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title> HoHwanMaMa </title>
    </head>
    <body>
        <h1> 제품 추가 </h1>
        <h5> 추가하실 제품의 정보를 입력하십시오. </h5>
        <br>
        
        <!--추천 4가지 조합 중 하나를 선택하면 해당 부품을 꾸러미에 넣는 과정 -->
        <hr>
        
        <?php
            $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

            $part_type_array=array("cpu","gpu","ram","ssd","hdd","mainboard","pc_case","cooler","power");
            for ($i=0;$i<9;$i++) {
                echo "<h3>",$part_type_array[$i],"</h3>";
                echo "<form method='get' action='add_new_product_follow.php'>";

                echo "제품 정보<br>";
                echo "<input type='text' name='part_type' placeholder='type'> <br>";
                echo "<input type='text' name='part_number' placeholder='number'> <br>";
                echo "<input type='text' name='part_name' placeholder='name'> <br>";

                $sql="DESC ";
                $sql.=$part_type_array[$i];
                $ret=mysqli_query($con,$sql);
                echo "상세 정보<br>";
                while ($row=mysqli_fetch_array($ret)) {
                    echo "<input type='text' name='",$row['Field'],"' placeholder='",$row['Field'],"'> <br>";
                }

                echo "<br><input type='submit' value='추가' formaction='add_new_product_follow.php'/>";

                echo "</form><br><hr>";
            }

            mysqli_close($con);
        ?>

        <form>
            호환 정보<br>
            <input type='text' name='spec_type' placeholder='type'> <br>
            <input type='text' name='spec_name' placeholder='name'> <br>
            <input type='text' name='spec_rnc' placeholder='rnc'> <br>
            <input type='text' name='spec_comp' placeholder='comp'> <br>

            <br><input type='submit' value='추가' formaction='add_new_spec.php'/>
        </form>

        <br><hr>
        <a href="main.html"> 로그인 화면으로 이동.. </a>
    </body>
</html>