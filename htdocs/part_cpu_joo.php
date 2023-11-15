<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>part_cpu</title>
</head>
<body>
  <?php
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=cpu'>CPU</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=gpu'>그래픽카드</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=mainboard'>메인보드</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=ram'>램</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=ssd'>SSD</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=hdd'>HDD</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=power'>파워</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=cooler'>쿨러</a>&nbsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=pc_case'>케이스</a>&nbsp;";
  ?>
    
    &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
    <a href="main.html">로그아웃</a>&nbsp;<br><br>

    <?php
      $con=mysqli_connect("localhost", "root", "5964", "mydb") or die("MySQL 접속 실패 !!");

      echo "<h3>";
      echo strtoupper($_GET['type']);
      echo "</h3>";
    
      echo "<form method='get' action='part_cpu_joo.php'>";

      echo "<input type='hidden' name='type' value='",$_GET['type'],"'>";

      echo "<hr>";

      $sql_field="DESC ";
      $sql_field.=$_GET['type'];
      $ret_field=mysqli_query($con,$sql_field);
      while ($row_field=mysqli_fetch_array($ret_field)) {
        if ($row_field['Field']=='Price'||$row_field['Field']=='Class'||$row_field['Field']=='product_number') continue;

        echo $row_field['Field'];
        echo "<br>";

        $sql_spec="SELECT DISTINCT ";
        $sql_spec.=$row_field['Field'];
        $sql_spec.=" FROM ";
        $sql_spec.=$_GET['type'];
        $sql_spec.=" ORDER BY ";
        $sql_spec.=$row_field['Field'];
        $ret_spec=mysqli_query($con,$sql_spec);
        while ($row_spec=mysqli_fetch_array($ret_spec)) {
          if($row_field['Type']=='int'||$row_field['Type']=='tinyint') {
            echo "<input type='checkbox' name='",$_GET['type'],"_",$row_spec[$row_field['Field']],"' value=",$row_spec[$row_field['Field']]," />",$row_spec[$row_field['Field']],"&nbsp;";
          }
          else {
            echo "<input type='checkbox' name='",$_GET['type'],"_",$row_spec[$row_field['Field']],"' value='",$row_spec[$row_field['Field']],"' />",$row_spec[$row_field['Field']],"&nbsp;";
          }  
        }
        echo "<br>";
      }

      echo "<input type='reset' value='초기화' />&emsp;";

      
      echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";
      
      echo "<input type='submit' value='검색' formaction='part_cpu1_joo.php'/>";

      echo "</form>";

      mysqli_close($con);
    ?>
    

        <hr>
 
        <h3>POCKET</h3>

        <?php
          $con=mysqli_connect("localhost","root","5964","mydb") or die("MySQL 접속 실패 !!");
          $sql ="SELECT * FROM pocket ";
          $sql.="JOIN part ON pocket.product_number =part.product_number ";
          $sql.="WHERE pocket.ID='";
          $sql.=$_GET['user_id'];
          $sql.="'";
          
          $ret=mysqli_query($con,$sql);

          while ($row=mysqli_fetch_array($ret)) {
            echo "<form method='get'>";
            echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";
            echo "<input type='hidden' name='product_number' value='",$row['product_number'],"'>";
            echo "<input type='hidden' name='type' value='",$_GET['type'],"'>";
            echo $row['Type']," : ",$row['Name_of_product']," ( ",$row['Quantity']," 개 )";
            echo "<br>";
            echo "<input type='submit' value='삭제' formaction='part_delete.php'/><br>";
            echo "</form>";
          }
          // echo "<input type='submit' value='삭제' formaction='part_remove?user_id='",$_GET['user_id'],"'.php'>";

        echo "<form>";
        echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";
        echo "<hr><input type='submit' value='호환성검사' formaction='compatibility_check.php'/>";
        echo "</form>";

        mysqli_close($con);
        ?>
</body>
</html>
