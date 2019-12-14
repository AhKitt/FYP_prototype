<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];

$sql = "SELECT * FROM advertisement WHERE advertiser = '$email' ORDER BY adsid DESC";

$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["ads"] = array();
    while ($row = $result ->fetch_assoc()){
        $adslist = array();
        $adslist[adsid] = $row["adsid"];
        $adslist[title] = $row["title"];
        $adslist[description] = $row["description"];
        $adslist[address] = $row["address"];
        $adslist[radius] = $row["radius"];
        $adslist[lat] = $row["lat"];
        $adslist[lng] = $row["lng"];
        $adslist[status] = $row["status"];
        $adslist[adsimage] = $row["adsimage"];
        $adslist[postdate] = date_format(date_create($row["postdate"]), 'd/m/Y h:i:s');
        $adslist[duedate] = date_format(date_create($row["duedate"]), 'd/m/Y h:i:s');
        array_push($response["ads"], $adslist);    
    }
    echo json_encode($response);
}else{
    echo "nodata";
}

?>