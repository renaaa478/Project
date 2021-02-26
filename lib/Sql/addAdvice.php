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

  if($var['B_id'] != ''){
		$bid = $var['B_id'];
		$nid = $var['N_id'];
		$pid = $var['P_id'];
    $advice= $var['advice'];
    
   
							
		$sql = "INSERT INTO `advice`(`B_id`, `P_id`, `N_id`, `advice`) 
        VALUES('$bid','$pid','$nid','$advice')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			$data = array("status"=>"true");
      $sql1 = "UPDATE `book` SET `Bb_status`=3 WHERE B_id = $bid";
      $result1 = mysqli_query($link, $sql1);
      if ($result1) {
        $data= array("status"=>"true");
        
      }
      else{
        $data = array("status"=>"false");
      }
		} else {
			$data = array("status"=>"false");
		}

  }else{
    $data = array("status"=>"false");
  }

  echo json_encode($data);
	mysqli_close($link);
