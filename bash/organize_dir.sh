#!/bin/bash
echo "hi" 
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 /path/to/folder"
    exit 1
fi

FOLDER="$1"
if [[ ! -d "$FOLDER" ]]; then
    echo "Error: $FOLDER is not a valid directory."
    exit 1
fi

read -p "Do you want to 'move' or 'copy' the files? (type 'move' or 'copy'): " ACTION
if [[ "$ACTION" != "move" && "$ACTION" != "copy" ]]; then
    echo "Invalid choice. Exiting..."
    exit 1
fi

declare -A CATEGORIES
CATEGORIES["Scanner"]="nmap|masscan|scan"
CATEGORIES["Exploitation"]="metasploit|exploit|vuln"
CATEGORIES["Web_Tools"]="burp|web|dirbuster"
CATEGORIES["Password_Cracking"]="hydra|john|hashcat|cracker"
CATEGORIES["Sniffing"]="wireshark|tcpdump|sniff"

for file in "$FOLDER"/*; do
    if [[ -f "$file" ]]; then
        filename="$(basename "$file")"
        lower_filename=$(echo "$filename" | tr '[:upper:]' '[:lower:]')
        matched_categories=()

        for category in "${!CATEGORIES[@]}"; do
            if echo "$lower_filename" | grep -qE "${CATEGORIES[$category]}"; then
                matched_categories+=("$category")
            fi
        done

        if [[ ${#matched_categories[@]} -eq 0 ]]; then
            matched_categories=("Other")
        fi

        for category in "${matched_categories[@]}"; do
            dest_dir="$FOLDER/$category"
            mkdir -p "$dest_dir"
            if [[ "$ACTION" == "move" ]]; then
                echo "Moving '$filename' to '$dest_dir'"
                mv "$file" "$dest_dir/"
            elif [[ "$ACTION" == "copy" ]]; then
                echo "Copying '$filename' to '$
