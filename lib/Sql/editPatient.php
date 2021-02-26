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

  if($_GET['username'] != ''){
		$P_name = $_GET['nameUser'];
		$P_sernmae = $_GET['surname'];
		$P_phone = $_GET['phones'];
    $P_add= $_GET['add'];
    $P_email= $_GET['mail'];
    $P_con=$_GET['con'];
    $username= $_GET['username'];
   
							
		$sql = "UPDATE  `patient` SET 
    P_name = '$P_name' , P_sername ='$P_sernmae',	P_email = '$P_email' , P_phone ='$P_phone' , P_add ='$P_add', P_con ='$P_con'
    where P_username = '$username'";
       

		$result = mysqli_query($link, $sql);

		if ($result) {
			$data = array("status"=>"true");
      $sql1 = "UPDATE `usertable` SET `name`= '$P_name', surname ='$P_sernmae' WHERE user = '$username'";
      $result1 = mysqli_query($link, $sql1);
      if ($result1) {
        $data= array("status"=>"true");
        # code...
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
