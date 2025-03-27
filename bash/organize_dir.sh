#!/bin/bash

# Ensure the script is executed with exactly one argument
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

TARGET_FOLDER="$1"

# Check if the provided argument is a valid directory
if [[ ! -d "$TARGET_FOLDER" ]]; then
    echo "Error: '$TARGET_FOLDER' is not a valid directory."
    exit 1
fi

# Prompt the user to choose between moving or copying files
read -p "Do you want to 'move' or 'copy' the files? (type 'move' or 'copy'): " ACTION
if [[ "$ACTION" != "move" && "$ACTION" != "copy" ]]; then
    echo "Invalid choice. Exiting..."
    exit 1
fi

# Define file categories and their matching keywords
declare -A FILE_CATEGORIES
FILE_CATEGORIES["Scanner"]="nmap|masscan|scan"
FILE_CATEGORIES["Exploitation"]="metasploit|exploit|vuln"
FILE_CATEGORIES["Web_Tools"]="burp|web|dirbuster"
FILE_CATEGORIES["Password_Cracking"]="hydra|john|hashcat|cracker"
FILE_CATEGORIES["Sniffing"]="wireshark|tcpdump|sniff"

# Iterate over each file in the target directory
for file in "$TARGET_FOLDER"/*; do
    if [[ -f "$file" ]]; then
        filename="$(basename "$file")"
        lower_filename=$(echo "$filename" | tr '[:upper:]' '[:lower:]')
        matched_categories=()

        # Check if the filename matches any category keywords
        for category in "${!FILE_CATEGORIES[@]}"; do
            if echo "$lower_filename" | grep -qE "${FILE_CATEGORIES[$category]}"; then
                matched_categories+=("$category")
            fi
        done

        # If no categories matched, assign the file to the "Other" category
        if [[ ${#matched_categories[@]} -eq 0 ]]; then
            matched_categories=("Other")
        fi

        # Move or copy the file to the appropriate category directory
        for category in "${matched_categories[@]}"; do
            dest_dir="$TARGET_FOLDER/$category"
            mkdir -p "$dest_dir"
            if [[ "$ACTION" == "move" ]]; then
                echo "Moving '$filename' to '$dest_dir'"
                mv "$file" "$dest_dir/"
            elif [[ "$ACTION" == "copy" ]]; then
                echo "Copying '$filename' to '$dest_dir'"
                cp "$file" "$dest_dir/"
            fi
        done
    fi
done
