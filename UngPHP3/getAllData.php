<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
header("content-type:text/javascript;charset=utf-8");
$link = mysqli_connect('localhost', 'androidh_sam', 'Abc12345', "androidh_sam");

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

	$result = mysqli_query($link, "SELECT * FROM userTABLE_master");
   
	while($row=mysqli_fetch_assoc($result)){
	$output[]=$row;
	}

	echo json_encode($output);

	mysqli_close($link);
?>