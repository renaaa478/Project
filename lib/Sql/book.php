<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "project");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

// Start----------------------------------------
  $json = file_get_contents('php://input');
  $var = json_decode($json, true);
  $out_date = date("Y-m-d");
  date_default_timezone_set('Asia/Bangkok');

  if($var['N_id'] != ''){
		$Nid = $var['N_id'];
        $Bdate = $var['B_date_ser'];
        $pid = $var['P_id'];
        $sid = $var['S_id'];
        $status = $var['B_status'];
        $timeS = $var['B_timesttr'];
        $timeE = $var['B_time_end'];
        $hos = $var['B_hos'];
        $fee = $var['B_fee'];

        $idser = (int)$sid;
        $time1 = (int)$timeS;
        $time2 = (int)$timeE;
        $hr = $time2 - $time1;
        // if ($idser == 1) 
        // { 
        //   $sql1 = "SELECT *FROM set_service
        //   WHERE id_ser ='$idser'";
        //   $result2 = mysqli_query($link, $sql1);
        //   while ($row = $result2->fetch_assoc()) {
        //     $ser_time =$row['Ser_time'];
        //     $ser_charge = $row['Ser_charge'];
        //   }
        //   $fee = $ser_charge+$ser_time;
        // }
        // else
        // {
        //   $sql2 ="SELECT *FROM nurse
        //   WHERE N_id ='$Nid'";
        //   $result3 = mysqli_query($link, $sql2);
        //   while ($row = $result3->fetch_assoc()) {
        //     $typeN = $row['Nn_id'];
        //   }
        //   $sql3 ="SELECT *FROM set_service
        //   WHERE Nn_id ='$typeN'";
        //   $result4 = mysqli_query($link, $sql3);
        //   while ($row = $result4->fetch_assoc()) {
        //     $ser_charge = $row['Ser_charge'];
        //     $ser_hr = $row['Ser_hr'];
        // }
        // $fee = $ser_charge+($ser_hr*$hr);
        // }
        if ($sid != ' ') {
          $sql4 ="SELECT *
          FROM book
          where  N_id = '".$Nid."'
    AND B_date_ser = '".$Bdate."'
    AND B_timesttr <= '$time1'
    AND B_time_end >= '".$time2."' 
    OR
    N_id = '".$Nid."'
    AND B_date_ser = '".$Bdate."'
    AND B_timesttr >= '$time1'
    AND B_time_end <= '".$time2."' 
    OR
    N_id = '".$Nid."'
    AND B_date_ser = '".$Bdate."'
    AND B_timesttr <= '$time1'
    AND B_time_end <= '".$time2."' 
    OR
    N_id = '".$Nid."'
    AND B_date_ser = '".$Bdate."'
    AND B_timesttr >= '$time1'
    AND B_time_end >= '".$time2."' 
    ";
    $result1 = mysqli_query($link, $sql4);
    if ($result1->num_rows > 0) {
      $data = array("status"=>"false");
    }
    else{
      $sql = "INSERT INTO `book`(`B_date`, `N_id`, `P_id`, `S_id`, `B_status`, `B_timesttr`, `B_time_end`, `B_hos`,`B_fee`, `B_date_ser`) 
      VALUES ('$out_date','$Nid','$pid','$sid','$status','$timeS','$timeE','$hos','$fee','$Bdate')";

  $result = mysqli_query($link, $sql);

  if ($result) {
    $data = array("status"=>"true");
  } else {
    $data = array("status"=>"false");
  }
    }
        }

  }else{
    $data = array("status"=>"false");
  }

  echo json_encode($data);
	mysqli_close($link);
