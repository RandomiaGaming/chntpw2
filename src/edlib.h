#ifndef EDLIB_H
#define EDLIB_H

void cat_dpi(struct hive *hdesc, int nkofs, char *path);
void cat_vk(struct hive *hdesc, int nkofs, char *path, int dohex);
void edit_val(struct hive *h, int nkofs, char *path);
void nv_help();
void regedit_interactive(struct hive *hive[], int no_hives);

#endif // EDLIB_H