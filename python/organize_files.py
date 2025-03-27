import os
import shutil
import sys

CATEGORY_KEYWORDS = {
    "Scanner": ["nmap", "masscan", "scan"],
    "Exploitation": ["metasploit", "exploit", "vuln"],
    "Web_Tools": ["burp", "web", "dirbuster"],
    "Password_Cracking": ["hydra", "john", "hashcat", "cracker"],
    "Sniffing": ["wireshark", "tcpdump", "sniff"],
}

def get_categories(filename):
    """Return all categories a tool might belong to."""
    lower_name = filename.lower()
    categories = []
    for category, keywords in CATEGORY_KEYWORDS.items():
        if any(keyword in lower_name for keyword in keywords):
            categories.append(category)
    return categories if categories else ["Other"]

def organize_tools(source_dir, action):
    """Organize tools by copying or moving them."""
    if not os.path.isdir(source_dir):
        print(f"Error: {source_dir} is not a valid directory.")
        return

    for entry in os.listdir(source_dir):
        full_path = os.path.join(source_dir, entry)
        if os.path.isfile(full_path):
            categories = get_categories(entry)
            for category in categories:
                dest_dir = os.path.join(source_dir, category)
                os.makedirs(dest_dir, exist_ok=True)
                dest_path = os.path.join(dest_dir, entry)
                if os.path.exists(dest_path):
                    continue  # Avoid duplicates
                if action == "move":
                    print(f"Moving '{entry}' to '{dest_dir}'")
                    shutil.move(full_path, dest_path)
                elif action == "copy":
                    print(f"Copying '{entry}' to '{dest_dir}'")
                    shutil.copy(full_path, dest_path)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python organize_tools.py /path/to/folder")
    else:
        action = input("Do you want to 'move' or 'copy' the files? (type 'move' or 'copy'): ").strip().lower()
        if action not in ["move", "copy"]:
            print("Invalid choice. Exiting...")
        else:
            organize_tools(sys.argv[1], action)
