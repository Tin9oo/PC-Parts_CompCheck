<?php
    echo "<h1> Recommand choice spec </h1>";
    echo "<h5> 원하시는 정도의 사양을 선택하십시오. </h5>";

    echo "<form method='get' action='recommand.php'>";
    echo "<input type='hidden' name=user_id value=", $_GET["user_id"], ">";
    $choice_spec=array("cpu", "gpu", "ram");
    for($i=0; $i<3; $i++) {
        echo strtoupper($choice_spec[$i])," : <input type='radio' name=", $choice_spec[$i], " value='1' required/> Office
            <input type='radio' name=", $choice_spec[$i], " value='2'/> 2D Game
            <input type='radio' name=", $choice_spec[$i], " value='3'/> 3D Game
            <input type='radio' name=", $choice_spec[$i], " value='4'/> Expert
            <br>";
    }
    echo "SSD : <input type='radio' name='ssd' value='256gb' required/> 256GB
    <input type='radio' name='ssd' value='512gb'/> 512GB
    <input type='radio' name='ssd' value='1tb'/> 1TB
    <input type='radio' name='ssd' value='2tb'/> 2TB
    <br><br>";

    echo "<hr><input type='submit' value='추천 받기'/>&emsp;&emsp;";
    echo "<input type='reset' value='초기화'/>";
    echo "</form>";

    echo "<br>";
    echo "<input type='button' value='이전' onClick='history.go(-1)'>";
    //echo "<a href='select_service.php?user_id=", $_GET["user_id"], "'> 이전 화면으로 이동.. </a> <br>";
    echo "<a href='main.html'> 로그인 화면으로 이동.. </a>";
?>