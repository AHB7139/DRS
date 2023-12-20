<?php
include 'db.php';

if ($_SERVER["REQUEST_METHOD"] == "GET") {
    $tracking_number = $_GET['tracking_number'];

    $sql = "SELECT d.tracking_number, d.document_id, d.is_terminal, o.office_name, dt.timestamp, d.created_at
            FROM Documents d
            LEFT JOIN DocumentTrail dt ON d.document_id = dt.document_id
            LEFT JOIN Offices o ON dt.office_id = o.office_id
            WHERE d.tracking_number = '$tracking_number'";

    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $is_terminal = $row["is_terminal"] == 1 ? "Yes" : "No";
            
            echo "Tracking Number: " . $row["tracking_number"] . "<br>";
            echo "Document ID: " . $row["document_id"] . "<br>";
            echo "Creation Date: " . $row["created_at"]. "<br>";;
            

            if ($row["office_name"] !== null && $row["timestamp"] !== null) {
                echo "Recipient Office: " . $row["office_name"] . "<br>";
                echo "Date Received: " . $row["timestamp"]. "<br>";
            } else {
                echo "Recipient Office: " ."<br>";
                echo "Date Received: ". "<br>";
            }
            
            echo "Terminated: " . $is_terminal . "<br><br>";
        }
    } else {
        echo "Document not found";
    }
    $conn->close();
}
?>
