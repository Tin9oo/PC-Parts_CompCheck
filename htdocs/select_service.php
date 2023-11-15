<?php
    echo "<h1> Select service </h1>";
    echo "<a href='recommand_choice_spec.php?user_id=", $_GET["user_id"], "'> 추천받겠습니다. </a>&emsp;&emsp;";
    echo "<a href='part_cpu_joo.php?user_id=", $_GET["user_id"], "&type=cpu'> 직접 선택하겠습니다. </a>";

    echo "<br><br><a href='main.html'> 로그인 화면으로 이동.. </a>";
?>