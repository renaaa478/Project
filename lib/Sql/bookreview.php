<?php
header("content-type:text/javascript;charset=utf-8");
error_reporting(0);
error_reporting(E_ERROR | E_PARSE);
$link = mysqli_connect('localhost', 'root', '', "project");
$out_date = date("Y-m-d");
date_default_timezone_set('Asia/Bangkok');

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
    $pid = $_GET['pid'];



    $result = mysqli_query($link, "SELECT *
    FROM ((((book
    INNER JOIN nurse ON book.N_id = nurse.N_id)
    INNER JOIN type_care ON nurse.Nn_id = type_care.Nn_id)
    INNER JOIN service_type ON book.S_id = service_type.id_ser)
    INNER JOIN patient ON book.P_id = patient.P_id) where Bb_status = 3 AND book.P_id ='$pid' order by B_date_ser DESC");

    if ($result) {

      while ($row = mysqli_fetch_assoc($result)) {
        $output[] = $row;
      }  // while

      echo json_encode($output);
    } //if

  } else json_encode($output = array("status" => "false"));  // if2

  // if1
}

mysqli_close($link);
