<?php
    $link = mysql_connect("aiyess.ipagemysql.com", "psj", "asdQWE123!@#");
    if (!$link) {
        die('Could not connect: ' . mysql_error());
    }
    $sel_db = mysql_select_db('psj_database');
    
    $sql_task = "select * from sample_table";
    $res = mysql_query($sql_task) ;
    $row = mysql_fetch_object($res) ;
    echo json_encode($row);
    mysql_close($link);
    
?>