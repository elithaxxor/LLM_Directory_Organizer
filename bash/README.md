## `organize_dir.sh`  

```markdown
# Directory Organizer Script

## Overview

The `organize_dir.sh` script is a Bash script designed to organize files within a specified directory into categorized subdirectories based on their filenames. The script allows users to either move or copy files to their respective categories.

## Features

- Organizes files into categories based on keywords in filenames.
- Supports moving or copying files.
- Provides default category assignment for unrecognized files.

## Categories

The script categorizes files into the following predefined categories:

- **Scanner**: Includes files related to scanning tools like nmap, masscan, etc.
- **Exploitation**: Includes files related to exploitation tools like metasploit, exploit, etc.
- **Web_Tools**: Includes files related to web tools like burp, dirbuster, etc.
- **Password_Cracking**: Includes files related to password cracking tools like hydra, john, etc.
- **Sniffing**: Includes files related to sniffing tools like wireshark, tcpdump, etc.
- **Other**: Default category for files that do not match any predefined keywords.

## Usage

### Prerequisites

Ensure you have Bash installed on your system. This script is designed to run on Unix-like operating systems.

### Running the Script

1. Download or clone the repository to your local machine:
   ```bash
   git clone https://github.com/elithaxxor/LLM_Directory_Organizer.git
   cd LLM_Directory_Organizer/bash
   ```

2. Make the script executable:
   ```bash
   chmod +x organize_dir.sh
   ```

3. Run the script with the path to the directory you want to organize:
   ```bash
   ./organize_dir.sh /path/to/folder
   ```

4. Follow the prompt to choose whether to move or copy the files:
   ```text
   Do you want to 'move' or 'copy' the files? (type 'move' or 'copy'):
   ```

## Example

Suppose you have a directory with the following files:

```
/path/to/folder
├── nmap_scan.txt
├── metasploit_exploit.txt
├── burp_scan.txt
├── hydra_password.txt
├── wireshark_capture.pcap
```

Running the script and choosing to move the files will result in the following structure:

```
/path/to/folder
├── Scanner
│   └── nmap_scan.txt
├── Exploitation
│   └── metasploit_exploit.txt
├── Web_Tools
│   └── burp_scan.txt
├── Password_Cracking
│   └── hydra_password.txt
├── Sniffing
│   └── wireshark_capture.pcap
```

 [elithaxxor](https://github.com/elithaxxor)
 @copyleft material 
```
