<?php
error_reporting(0);
include_once ("dbconnect.php");
$email = $_POST['email'];
$title = $_POST['title'];
$desc = $_POST['desc'];
$adsimage = $_POST['adsimage'];
$address = $_POST['address'];
$radius = $_POST['radius'];
$lat = $_POST['lat'];
$lng = $_POST['lng'];
$period = $_POST['period'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);
$postdate =  date('Y-m-d H:i:s');
$adsimage = $postdate.'-'.$email;

if ($period == 7){
    $duedate = date('Y-m-d H:i:s', strtotime($postdate . ' +7 day'));
}else if($period == 15){
    $duedate = date('Y-m-d H:i:s', strtotime($postdate . ' +15 day'));
}else if($period == 30){
    $duedate = date('Y-m-d H:i:s', strtotime($stop_date . ' +30 day'));
}

$sqlinsert = "INSERT INTO advertisement(title,description,adsimage,address,radius,lat,lng,status,advertiser,period,postdate,duedate) VALUES ('$title','$description','$adsimage','$address','$radius','$lat','$lng','Approved','$email','$period','$postdate','$duedate')";

if ($conn->query($sqlinsert) === TRUE) {
        $path = '../advertisement/'.$adsimage.'.jpg';
        file_put_contents($path, $decoded_string);
        echo "success";
    } else {
        echo "failed";
    }
?>