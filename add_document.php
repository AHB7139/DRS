<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $document_id = $_POST['document_id'];
    $tracking_number = $_POST['tracking_number'];
    $originating_office_id = $_POST['originating_office_id'];

    $check_office_query = "SELECT * FROM Offices WHERE office_id = $originating_office_id";
    $office_result = $conn->query($check_office_query);

    if ($office_result->num_rows > 0) {
        $sql = "INSERT INTO Documents (document_id, tracking_number, originating_office_id) VALUES ('$document_id', '$tracking_number', $originating_office_id)";

        if ($conn->query($sql) === TRUE) {
            $fetch_doc_query = "SELECT document_id, tracking_number, o.office_name, created_at
                                FROM Documents d
                                INNER JOIN Offices o ON d.originating_office_id = o.office_id
                                WHERE d.document_id = '$document_id'";
            
            $doc_details = $conn->query($fetch_doc_query);

            if ($doc_details->num_rows > 0) {
                while ($row = $doc_details->fetch_assoc()) {
                    echo "Document ID: " . $row["document_id"] . "<br>";
                    echo "Tracking Number: " . $row["tracking_number"] . "<br>";
                    echo "Office Name: " . $row["office_name"] . "<br>";
                    echo "Time Created: " . $row["created_at"] . "<br>";
                }
            } else {
                echo "No details found for the added document.";
            }
        } else {
            echo "Error: " . $sql . "<br>" . $conn->error;
        }
    } else {
        echo "Office ID does not exist in the Offices table.";
    }
    $conn->close();
}
?>
