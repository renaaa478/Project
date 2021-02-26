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

if (isset($_GET)) {
  if ($_GET['isAdd'] == 'true') {
				
		$nid = $_GET['nid'];
	

		$result = mysqli_query($link, "SELECT * FROM nurse    
     WHERE N_id = '$nid'");
		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
                $output = $row['Nn_id'];

			}	// while

			echo json_encode($output);

		} //if

	} else json_encode($output=array("status"=>"false"));	// if2
   
// if1
}

	mysqli_close($link);
?>
