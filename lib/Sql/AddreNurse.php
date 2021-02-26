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

  if($var['user'] != ''){
		$name = $var['name'];
		$surname = $var['surname'];
		$address = $var['address'];
    $brith= $var['birth'];
    $weight =$var['weight'];
    $height =$var['height'];
    $type =$var['type'];
    $sex= $var['sex'];
    $age = $var['age'];
    $cer = $var['cer'];
    $email = $var['email'];
    $phone = $var['phone'];
    $username =$var['user'];
							
		$sql = "INSERT INTO `nurse`(`N_name`, `N_sername`, `N_email`, `N_phone`, `N_weight`, `N_height`, `N_birth`, `N_sex`, `N_age`, `N_cer`, `Nn_id`, `N_usern`) 
    VALUES('$name','$surname','$email','$phone','$weight','$height','$brith','$sex','$age','$cer','$type','$username')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			$data = array("status"=>"true");
		} else {
			$data = array("status"=>"false");
		}

  }else{
    $data = array("status"=>"false");
  }

  echo json_encode($data);
	mysqli_close($link);
