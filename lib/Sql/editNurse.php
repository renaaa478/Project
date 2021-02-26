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
		$N_name = $_GET['nameUser'];
		$N_sernmae = $_GET['surname'];
		$N_phone = $_GET['phones'];
        $N_add= $_GET['add'];
        $N_email= $_GET['mail'];
        $username= $_GET['username'];
        $h =$_GET['h'];
        $w=$_GET['w'];
   
							
		$sql = "UPDATE `nurse` SET N_name = '$N_name' , N_sername ='$N_sernmae', N_email = '$N_email' , N_phone ='$N_phone', N_add ='$N_add', N_weight= '$w' ,N_height=' $h' where N_usern = '$username'";
       

		$result = mysqli_query($link, $sql);

		if ($result) {
			$data = array("status"=>"true");
      $sql1 = "UPDATE `usertable` SET `name`= '$N_name', surname ='$N_sernmae' WHERE user = '$username'";
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
