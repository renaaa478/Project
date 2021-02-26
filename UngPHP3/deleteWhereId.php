<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'androidh_pen', 'Abc12345', "androidh_pen");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}else {

	if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
			
		$id = $_GET['id'];		
									
		$sql = "DELETE FROM testTABLE WHERE id = '$id'";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "True";
		} else {
			echo "False";
		}

	} else echo "Welcome Master UNG";
   
}
	
}
	mysqli_close($link);
?>