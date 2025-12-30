/*
    For some reason i thought waybar didn't have hyprland/workspaces and just sway/workspaces.
    
    So i made this to fetch and print json but it's not necessary.
    Problem is that custom modules can't make multiple widgets div/span with specialized css boxshadow,margin,padding
    for each workspace.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    FILE *fp = popen("hyprctl workspaces", "r");
    if (!fp) return 1;

    char line[512];
    int first = 1;

    printf("{\"text\":\"");

    // printf("[");
    // while (fgets(line, sizeof(line), fp)) {
    //     int ws_id = 0;
    //     int windows = 0;

    //     // Detect workspace line
    //     if (sscanf(line, "workspace ID %d", &ws_id) == 1) {
    //         // Read next few lines to find 'windows: N'
    //         while (fgets(line, sizeof(line), fp)) {
    //             if (sscanf(line, "\twindows: %d", &windows) == 1) break;
    //         }

    //         const char *icon = windows > 0 ? "" : "";

    //         if (!first) printf(",");
    //         printf("{\"text\":\"%s\",\"class\":\"workspace%d\"}", icon, ws_id);
    //         first = 0;
    //         break;
    //     }
    // }
    printf("<span>[1]</span><span>[2]</span>");
    printf("\"}");

    pclose(fp);
    return 0;
}
