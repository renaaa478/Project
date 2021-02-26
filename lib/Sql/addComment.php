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

  if($var['B_id'] != ''){
		$bid = $var['B_id'];
		$nid = $var['N_id'];
		$pid = $var['P_id'];
    $comment= $var['comment'];
   
							
		$sql = "INSERT INTO `comment`(`C_date`, `C_com`, `P_id`, `N_id`, `B_id`) VALUES
        ('$out_date','$comment','$pid','$nid','$bid')";

		$result = mysqli_query($link, $sql);
    $data = array("status"=>"true");
		

  }else{
    $data = array("status"=>"false");
  }

  echo json_encode($data);
	mysqli_close($link);
