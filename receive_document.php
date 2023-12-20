<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $document_id = $_POST['document_id'];
    $receiving_office_id = $_POST['receiving_office_id'];

    $check_document_query = "SELECT * FROM Documents WHERE document_id = ?";
    $stmt = $conn->prepare($check_document_query);
    $stmt->bind_param("s", $document_id);
    $stmt->execute();
    $document_result = $stmt->get_result();

    if ($document_result->num_rows > 0) {
        $sql = "INSERT INTO DocumentTrail (document_id, office_id, timestamp) VALUES (?, ?, NOW())";
        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $document_id, $receiving_office_id);

        if ($stmt->execute()) {
            echo "Document received successfully";
        } else {
            echo "Error: " . $stmt->error;
        }
    } else {
        echo "Document ID does not exist in the Documents table.";
    }
    $conn->close();
}
?>
