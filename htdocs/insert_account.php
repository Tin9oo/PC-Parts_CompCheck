<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title> HoHwanMaMa </title>
</head>
<body>

<?php
  $username = $_POST[ 'ID' ];
  $password = $_POST[ 'Password' ];
  $password_verify = $_POST[ 'Password_verify' ];
  if ( !is_null( $username ) ) {
    $jb_conn = mysqli_connect("localhost","root","5964","mydb");
    $jb_sql = "SELECT ID FROM member WHERE ID = '$username';";
    $jb_result = mysqli_query( $jb_conn, $jb_sql );
    while ( $jb_row = mysqli_fetch_array( $jb_result ) ) {
      $username_e = $jb_row[ 'ID' ];
    }
    if ( $username == $username_e ) {
      $wu = 1;
	echo"중복된 아이디입니다.";
    } elseif ( $password != $password_verify ) {
      $wp = 1;
	echo"비밀번호가 같지 않습니다.";
    } else {
      $encrypted_password = password_hash( $password, PASSWORD_DEFAULT);
      $jb_sql_add_user = "INSERT INTO member ( username, password ) VALUES ( '$username', '$encrypted_password' );";
      mysqli_query( $jb_conn, $jb_sql_add_user );
      header( 'Location: register-ok.php' );
    }
  }

echo"<br><a href='main.html'>확인</a>";

?>

</body>
</html>