## PHP / Console output

```markdown

[[This simple PHP script will execute the compiled C program and display its output on a web page. Make sure that the compiled C program (`vanilla_organizer`) is in the same directory as the PHP file for this to work.]]

1. Compile the `vanilla_organizer.c` program.
2. Execute the compiled program from PHP.
3. Capture and display the output.

Here is a step-by-step guide and the PHP code:

### Step-by-Step Guide:

1. **Compile the C Program**:
   - Ensure you have `gcc` or any other C compiler installed.
   - Compile the C program using `gcc`:
     ```sh
     gcc -o vanilla_organizer vanilla_organizer.c
     ```

2. **Create a PHP Script**:
   - Create a PHP file (e.g., `server.php`).
   - Use the PHP `exec` function to run the compiled C program and capture its output.

3. **Run a PHP Server**:
   - Use the built-in PHP server to run your PHP script:
     ```sh
     php -S localhost:8000
     ```
   - Access the server at `http://localhost:8000/server.php`.

### PHP Code:

```php
<?php
// Path to the compiled C program
$programPath = './vanilla_organizer';

// Check if the compiled program exists
if (file_exists($programPath)) {
    // Execute the C program and capture the output
    $output = shell_exec($programPath);

    // Check if there was any output
    if ($output !== null) {
        // Display the output
        echo "<pre>$output</pre>";
    } else {
        echo "Error: No output from the C program.";
    }
} else {
    echo "Error: Compiled C program not found. Please compile vanilla_organizer.c.";
}
?>
```

### Steps to Deploy:

1. **Compile the C Program**:
   ```sh
   gcc -o vanilla_organizer vanilla_organizer.c
   ```

2. **Create the PHP File**:
   - Save the above PHP code in a file named `server.php`.

3. **Run the PHP Server**:
   ```sh
   php -S localhost:8000
   ```

4. **Access the Output**:
   - Open a web browser and navigate to `http://localhost:8000/server.php`.

```
