<?php
// Path to the compiled C program
$programPath = './vanilla_organizer';

// Initialize output variable-- theres  only one variable 
$output = '';

// Check if the compiled program exists
if (file_exists($programPath)) {
    // Execute the C program and capture the output
    $output = shell_exec($programPath);

    // Check if there was any output
    if ($output === null) {
        $output = "Error: No output from the C program.";
    }
} else {
    $output = "Error: Compiled C program not found. Please compile vanilla_organizer.c.";
}

// Include the HTML file to display the output
include 'output.html';
?>
