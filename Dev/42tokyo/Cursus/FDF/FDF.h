#ifndef FDF_H
#define FDF_H

#include "libft/libft.h"
#include <mlx.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <fcntl.h>
#include <string.h>

#ifndef GL_SILENCE_DEPRECATION
#define GL_SILENCE_DEPRECATION
#endif
/*
 * ウィンドウサイズ、描画スケール、及び高さの倍率
 */
#define WIDTH 1000
#define HEIGHT 800
#define SCALE 30     // 座標の拡大率
#define ALT 10 // 高さ（z値）の倍率

/*
 * 高さマップを保持する構造体
 */
typedef struct s_map
{
    int **data;   // 各点の高さを保持する 2 次元配列
    int rows;     // 行数
    int cols;     // 列数
} t_map;

/*
 * FDF の環境（MiniLibX、地形データ、描画パラメータ）を保持する構造体
 */
typedef struct s_env
{
    void *mlx;
    void *win;
    t_map *map;
    double angle;    // Y軸周りの回転角度（左右回転）
    double angle_x;  // X軸周りの回転角度（前後回転）
    int offset_x;    // X方向の描画オフセット
    int offset_y;    // Y方向の描画オフセット
} t_env;

/*
 * プロトタイプ宣言
 */
t_map *parse_map(const char *filename);
void free_map(t_map *map);
void draw_map(t_env *env);
void draw_line(t_env *env, int x0, int y0, int x1, int y1, int color);
int key_hook(int keycode, t_env *env);
void isometric(int x, int y, int z, t_env *env, int *iso_x, int *iso_y);

void free_tokens(char **tokens);

#endif