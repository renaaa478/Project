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

				
		$nid = $_GET['nid'];

		$result = mysqli_query($link, "SELECT * FROM nurseincome WHERE N_id = '$nid' ORDER BY `nurseincome`.`B_date` DESC");

		if ($result) {

			while($row=mysqli_fetch_assoc($result)){
        // $incos = $row['price'];
        // $sum = $sum + $incos;
			$output[]=$row;

			}	// while
      $data=array("status"=>$sum);
			echo json_encode($output);
      // echo json_encode($sum);

		} //if

	} else json_encode($output=array("status"=>"false"));	// if2
   
// if1


	mysqli_close($link);
?>
