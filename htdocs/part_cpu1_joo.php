<?php
  $con=mysqli_connect("localhost","root","5964","mydb") or die("MySQL 접속 실패 !!");
  ini_set('display_errors', '0');

  $sql_search ="SELECT *  FROM ";
  $sql_search.=$_GET['type'];
  $sql_search.=" INNER JOIN part ON part.product_number = ";
  $sql_search.=$_GET['type'];
  $sql_search.=".product_number ";
  $sql_search.=" WHERE (";

  $sql_field="DESC ";
  $sql_field.=$_GET['type'];
  $ret_field=mysqli_query($con,$sql_field);

  while($row_field=mysqli_fetch_array($ret_field)) {
    if ($row_field['Field']=='Price'||$row_field['Field']=='Class'||$row_field['Field']=='product_number') continue;

    $sql_search.="(";

    $sql_spec="SELECT DISTINCT ";
    $sql_spec.=$row_field['Field'];
    $sql_spec.=" FROM ";
    $sql_spec.=$_GET['type'];
    $sql_spec.=" ORDER BY ";
    $sql_spec.=$row_field['Field'];
    $ret_spec=mysqli_query($con,$sql_spec);
    while($row_spec=mysqli_fetch_array($ret_spec)) {
      // $tmp=$_GET['type'];
      // $tmp.="_";
      // $tmp.=$row_spec[$row_field['Field']];
      // if ($_GET[$tmp]=='') continue;

      if($row_field['Type']=='int'||$row_field['Type']=='tinyint') {
        $sql_search.=$row_field['Field'];
        $sql_search.=" = ";
        $tmp=$_GET['type'];
        $tmp.="_";
        $tmp.=$row_spec[$row_field['Field']];
        $sql_search.=$_GET[$tmp];
        if (substr($sql_search,-1)==" ") $sql_search.="-1";
        $sql_search.=" OR ";
      }
      else {
        $sql_search.=$row_field['Field'];
        $sql_search.=" = '";
        $tmp=$_GET['type'];
        $tmp.="_";
        $tmp.=$row_spec[$row_field['Field']];
        $sql_search.=$_GET[$tmp];
        $sql_search.="' OR ";
      }
    }
    $sql_search=substr($sql_search,0,-4);
    $sql_search.=" ) AND ";
  }
  $sql_search=substr($sql_search,0,-5);
  $sql_search.=" )";

  //echo "<br>",$sql_search,"<br>";
  
  $ret_search=mysqli_query($con,$sql_search);
  while($row_search=mysqli_fetch_array($ret_search)) {
    echo "<form method='get'>";
    echo "<input type='hidden' name='type' value='",$_GET['type'],"'>";
    echo "<input type='hidden' name='product_name' value='",$row_search['Name_of_product'],"'>";
    echo "<input type='hidden' name='product_number' value='",$row_search['product_number'],"'>";
    echo "<input type='hidden' name='user_id' value='",$_GET['user_id'],"'>";

    echo "<h3>제품명 : ",$row_search['Name_of_product'],"</h3><br>";

    $sql_field="DESC ";
    $sql_field.=$_GET['type'];
    $ret_field=mysqli_query($con,$sql_field);
    while ($row_field=mysqli_fetch_array($ret_field)) {
      if ($row_field['Field']=='Price'||$row_field['Field']=='Class'||$row_field['Field']=='product_number') continue;
      echo $row_field['Field']," : ",$row_search[$row_field['Field']],"<br>";
    }

    echo "Price : ",$row_search['Price']," 원<br>";

    echo "<hr>";
    echo "<input type='submit' value='추가' formaction='part_insert.php'>";
    echo "</form><br>";
    
  }

  echo "<br>";
  echo "<form>";
  echo "<input type='button' value='이전' onClick='history.go(-1)'>";
  echo "</form><br>";


  mysqli_close($con);
?>











