<?php
header('Access-Control-Allow-Origin: *');
include 'dbconnect.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    http_response_code(405);
    echo json_encode(array('error' => 'Method Not Allowed'));
    exit();
}

$user_id = $_POST['user_id'];
$pet_name = addslashes($_POST['pet_name']);
$pet_type = $_POST['pet_type'];
$category = $_POST['category'];
$pet_description = addslashes($_POST['pet_description']);
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];

$image_paths = [];

$sqlinsertpet = "INSERT INTO `tbl_pets`(`user_id`, `pet_name`, 'pet_type', `category`, `pet_description`, `latitude`, `longitude`) VALUES ('$user_id', '$pet_name', '$pet_type', '$category', '$pet_description', '$latitude', '$longitude')";

try {
    if ($conn->query($sqlinsertpet) === TRUE) {
        $pet_id = $conn->insert_id;

        for ($i = 1; $i <= 3; $i++) {
            $image_key = 'image' . $i;
            
            if (isset($_POST[$image_key]) && !empty($_POST[$image_key])) {
                $encodedimage = base64_decode($_POST[$image_key]);
                
                if ($encodedimage !== false) {
                    $path = "../assets/images/pets/pet_" . $pet_id . "_" . $i . ".jpg";
                    $result = file_put_contents($path, $encodedimage);
                    
                    if ($result !== false) {
                        $image_paths[] = $path;
                    }
                }
            }
        }
        
        // Update the record with image paths
        if (!empty($image_paths)) {
            $image_paths_json = json_encode($image_paths);
            $sqlupdate = "UPDATE `tbl_pets` SET `image_paths` = '$image_paths_json' WHERE `pet_id` = '$pet_id'";
            $conn->query($sqlupdate);
        }
        
        $response = array('status' => 'success', 'message' => 'Pet submitted successfully', 'pet_id' => $last_id);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'message' => 'Pet not added: ' . $conn->error);
        sendJsonResponse($response);
    }
} catch(Exception $e) {
    $response = array('status' => 'failed', 'message' => $e->getMessage());
    sendJsonResponse($response);
}

// Function to send JSON response
function sendJsonResponse($sentArray) {
    header('Content-Type: application/json');
    echo json_encode($sentArray);
    exit();
}
?>