#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <dirent.h>
#include <sys/stat.h>
#include <errno.h>

#define PATH_MAX_LEN 1024
#define MAX_CATEGORIES 10

void to_lowercase(char *str) {
    for (; *str; ++str)
        *str = tolower((unsigned char)*str);
}

void check_and_add_category(const char* lower_name, const char* keyword, const char* category, char categories[][512], int* num_categories) {
    if (strstr(lower_name, keyword) != NULL) {
        strncpy(categories[*num_categories], category, 512);
        (*num_categories)++;
    }
}

int get_categories(const char* filename, char categories[][512]) {
    char lower_name[512];
    int num_categories = 0;

    strncpy(lower_name, filename, sizeof(lower_name)-1);
    lower_name[sizeof(lower_name)-1] = '\0';
    to_lowercase(lower_name);

    check_and_add_category(lower_name, "nmap", "Scanner", categories, &num_categories);
    check_and_add_category(lower_name, "metasploit", "Exploitation", categories, &num_categories);
    check_and_add_category(lower_name, "burp", "Web_Tools", categories, &num_categories);
    check_and_add_category(lower_name, "hydra", "Password_Cracking", categories, &num_categories);
    check_and_add_category(lower_name, "wireshark", "Sniffing", categories, &num_categories);

    if (num_categories == 0) {
        strncpy(categories[num_categories], "Other", 512);
        num_categories++;
    }

    return num_categories;
}

void copy_file(const char* source, const char* destination) {
    FILE* src = fopen(source, "rb");
    FILE* dest = fopen(destination, "wb");
    if (!src || !dest) {
        perror("file copy");
        if (src) fclose(src);
        if (dest) fclose(dest);
        return;
    }

    char buffer[1024];
    size_t bytes;
    while ((bytes = fread(buffer, 1, sizeof(buffer), src)) > 0) {
        fwrite(buffer, 1, bytes, dest);
    }

    fclose(src);
    fclose(dest);
}

void organize_tools(const char* folder, const char* action) {
    DIR* dir = opendir(folder);
    if (!dir) {
        perror("opendir");
        return;
    }

    struct dirent* entry;
    char old_path[PATH_MAX_LEN], new_path[PATH_MAX_LEN], dest_folder[PATH_MAX_LEN];
    char categories[MAX_CATEGORIES][512];
    int num_categories;

    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0) continue;

        snprintf(old_path, sizeof(old_path), "%s/%s", folder, entry->d_name);

        struct stat st;
        if (stat(old_path, &st) == -1) {
            perror("stat");
            continue;
        }
        if (!S_ISREG(st.st_mode)) continue;

        num_categories = get_categories(entry->d_name, categories);

        for (int i = 0; i < num_categories; i++) {
            snprintf(dest_folder, sizeof(dest_folder), "%s/%s", folder, categories[i]);
            if (mkdir(dest_folder, 0755) != 0 && errno != EEXIST) {
                perror("mkdir");
                continue;
            }

            snprintf(new_path, sizeof(new_path), "%s/%s", dest_folder, entry->d_name);
            if (action && strcmp(action, "copy") == 0) {
                printf("Copying '%s' to '%s'\n", entry->d_name, dest_folder);
                copy_file(old_path, new_path);
            } else if (action && strcmp(action, "move") == 0) {
                printf("Moving '%s' to '%s'\n", entry->d_name, dest_folder);
                rename(old_path, new_path);
            }
        }
    }

    closedir(dir);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s /path/to/folder\n", argv[0]);
        return EXIT_FAILURE;
    }

    char action[16];
    printf("Do you want to 'move' or 'copy' the files? (type 'move' or 'copy'): ");
    scanf("%15s", action);

    if (strcmp(action, "move") != 0 && strcmp(action, "copy") != 0) {
        printf("Invalid choice. Exiting...\n");
        return EXIT_FAILURE;
    }

    organize_tools(argv[1], action);
    return EXIT_SUCCESS;
}
