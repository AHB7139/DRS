<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $document_id = $_POST['document_id'];

  
    $sql = "UPDATE Documents SET is_terminal = 1 WHERE document_id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $document_id); 

    if ($stmt->execute()) {
        echo "Document tagged as terminal";
    } else {
        echo "Error: " . $stmt->error;
        echo "SQL query: " . $sql; 
    }

    $stmt->close();
    $conn->close();
}
?>
