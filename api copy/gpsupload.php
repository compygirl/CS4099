<?php
    $longitidude = $_GET['lng'];
    $latidude = $_GET['lat'];
    $link = mysql_connect("aiyess.ipagemysql.com", "psj", "asdQWE123!@#");
    if (!$link) {
        die('Could not connect: ' . mysql_error());
    }
    
    $sel_db = mysql_select_db('psj_database');
    
    $sql_task = "select * from sample_table" ;
    
    $res = mysql_query($sql_task) ;
    
    $row = mysql_fetch_object($res) ;
    
    if($row->id){
        
        $sql = "UPDATE sample_table SET `lng`='$longitidude', `lat`='$latidude'";
    }else{
        $sql = "INSERT INTO sample_table(`lng`, `lat`) values('$longitidude', '$latidude')";
    }
    
    $retval = mysql_query($sql);
    
    if(! $retval )
    {
        die('Could not enter data: ' . mysql_error());
    }
     mysql_close($link);
    
?>