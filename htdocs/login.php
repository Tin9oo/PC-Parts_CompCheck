<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title></title>
</head>
<body>
   <?php
   session_start();
      $con = mysqli_connect("localhost","root","5964","mydb"); //db 연결
      
      $ID = $_POST['ID'];
      $Password = $_POST['Password'];
     
if ($ID=='admin' && $Password=='1234'){
   echo "<form>";
   echo "<br><input type='submit' value='관리자 페이지로 이동' formaction='add_new_product.php'/>";
   echo "<br><input type='submit' value='로그인 페이지로 복귀' formaction='main.html'/>";
   echo "</form>";
}
else if($ID==null)
{
echo"아이디를 입력하세요.";
} 
else if($Password==null)
{
echo"비밀번호를 입력하세요.";
}
else {
      $q = "SELECT * FROM Account WHERE ID = '$ID' AND Password = '$Password'";
      $result = mysqli_query($con,$q);
      $row = $result->fetch_array(MYSQLI_ASSOC);
      
      //결과가 존재하면 세션 생성
      if ($row != null) {
         $_SESSION['ID'] = $row['ID'];
         $header_location="Location: select_service.php?user_id=";
         $header_location.=$_SESSION['ID'];
         header( $header_location );
         
      }
      
      //결과가 존재하지 않으면 로그인 실패
      if($row == null){
         echo "가입된 아이디가 없습니다.","<br>";
         
      }
}
      ?>
<br>
<a href="signup.php"> 회원가입 </a><br>
<a href="main.html"> 로그인화면 </a>

   </body>