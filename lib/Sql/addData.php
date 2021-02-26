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
		$user = $var['user'];
		$password = $var['password'];
		$chooseType = $var['chooceType'];
							
		$sql = "INSERT INTO `usertable`(`chooseType`, `name`, `surname`, `user`, `password`) VALUES
     ('$chooseType','$name','$surname','$user','$password')";

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
