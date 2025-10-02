#ifndef EDLIB_H
#define EDLIB_H

#include "ntreg.h"

struct cmds
{
  char cmd_str[12];
  int cmd_num;
};

// edlib.c functions
void cat_dpi(struct hive *hdesc, int nkofs, char *path);
void cat_vk(struct hive *hdesc, int nkofs, char *path, int dohex);
void edit_val(struct hive *h, int nkofs, char *path);
int parsecmd(char **s, struct cmds *cmd);
void nv_help(void);
void regedit_interactive(struct hive *hive[], int no_hives);

#endif // EDLIB_H