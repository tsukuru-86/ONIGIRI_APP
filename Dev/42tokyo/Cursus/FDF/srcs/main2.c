// #include "../FDF.h"
// #include <math.h>

// /*
//  * isometric(): 3D座標 (x, y, z) をアイソメトリック投影し、画面上の座標 (iso_x, iso_y) に変換する。
//  */
// void isometric(int x, int y, int z, t_env *env, int *iso_x, int *iso_y)
// {
//     /*
//      * 以前の実装（シンプルなアイソメトリック投影）
//      * double rad_x = 30.0 * (M_PI / 180); // アイソメトリック角度を30度に設定
//      * double rad_y = 30.0 * (M_PI / 180); // 30度の角度をx, y軸に適用
//      *
//      * // アイソメトリック投影式
//      * *iso_x = round((x - y) * cos(rad_x) * SCALE + env->offset_x);
//      * *iso_y = round((x + y) * sin(rad_y) * SCALE - z * ALT + env->offset_y);
//      */

//     // 角度をラジアンに変換（初期状態として30度を加える）
//     double rad_y = (env->angle + 30.0) * (M_PI / 180.0);
//     double rad_x = (env->angle_x + 30.0) * (M_PI / 180.0);

//     // スケーリングを適用
//     double scaled_x = x * SCALE;
//     double scaled_y = y * SCALE;
//     double scaled_z = z * ALT;

//     // Y軸周りの回転
//     double rotY_x = scaled_x * cos(rad_y) - scaled_z * sin(rad_y);
//     double rotY_z = scaled_x * sin(rad_y) + scaled_z * cos(rad_y);

//     // X軸周りの回転
//     double final_y = scaled_y * cos(rad_x) - rotY_z * sin(rad_x);

//     // 投影とオフセットの適用
//     *iso_x = round(rotY_x + env->offset_x);
//     *iso_y = round(final_y + env->offset_y);
// }

// int get_color_from_z(int z)
// {
//     // z=0 -> 緑 (0x00FF00), z=10 -> 赤 (0xFF0000)
//     double t = (double)z / 10.0;
//     if (t > 1) t = 1;
//     if (t < 0) t = 0;
//     int red = (int)(255 * t);            // z=0 -> 0, z=10 -> 255
//     int green = (int)(255 * (1 - t));      // z=0 -> 255, z=10 -> 0
//     return (red << 16) | (green << 8);     // 青は0
// }


// int interpolate_color(int color_start, int color_end, double t)
// {
//     int r_start = (color_start >> 16) & 0xFF;
//     int g_start = (color_start >> 8) & 0xFF;
//     int b_start = color_start & 0xFF;
    
//     int r_end = (color_end >> 16) & 0xFF;
//     int g_end = (color_end >> 8) & 0xFF;
//     int b_end = color_end & 0xFF;
    
//     int r = (int)(r_start + (r_end - r_start) * t);
//     int g = (int)(g_start + (g_end - g_start) * t);
//     int b = (int)(b_start + (b_end - b_start) * t);
    
//     return (r << 16) | (g << 8) | b;
// }


// /*
//  * draw_line(): Bresenham のアルゴリズムにより、(x0, y0) から (x1, y1) までの直線を描画する。
//  */
// void draw_gradient_line(t_env *env, int x0, int y0, int x1, int y1, int z0, int z1)
// {
//     int dx = abs(x1 - x0);
//     int dy = abs(y1 - y0);
//     int sx = (x0 < x1) ? 1 : -1;
//     int sy = (y0 < y1) ? 1 : -1;
//     int err = dx - dy;
//     int total_steps = dx > dy ? dx : dy;  // 線分の長さに基づくステップ数
//     int current_step = 0;
//     double t;
//     int color;

//     // 始点と終点の標高から色を求める
//     int color_start = get_color_from_z(z0);
//     int color_end = get_color_from_z(z1);

//     while (1)
//     {
//         // 現在の進捗率 t を計算（0.0〜1.0）
//         t = (total_steps == 0) ? 0.0 : (double)current_step / total_steps;
//         // 補間して現在の色を決定
//         color = interpolate_color(color_start, color_end, t);
        
//         mlx_pixel_put(env->mlx, env->win, x0, y0, color);
//         if (x0 == x1 && y0 == y1)
//             break;
//         int e2 = 2 * err;
//         if (e2 > -dy)
//         {
//             err -= dy;
//             x0 += sx;
//         }
//         if (e2 < dx)
//         {
//             err += dx;
//             y0 += sy;
//         }
//         current_step++;
//     }
// }


// /*
//  * draw_map(): 読み込んだ地形データを元に各点をアイソメトリック変換し、隣接する点同士を線で結んでワイヤーフレームを描画する。
//  */
// void draw_map(t_env *env)
// {
//     int x, y;
//     int x0, y0, x1, y1;

//     mlx_clear_window(env->mlx, env->win);
//     for (y = 0; y < env->map->rows; y++)
//     {
//         for (x = 0; x < env->map->cols; x++)
//         {
//             int z = env->map->data[y][x];
//             // 現在の点 (x, y, z) をアイソメトリックに変換
//             isometric(x, y, z, env, &x0, &y0);

//             // 右隣の点とのグラデーション線を描画
//             if (x < env->map->cols - 1)
//             {
//                 int z_right = env->map->data[y][x + 1];
//                 isometric(x + 1, y, z_right, env, &x1, &y1);
//                 draw_gradient_line(env, x0, y0, x1, y1, z, z_right);
//             }

//             // 下の点とのグラデーション線を描画
//             if (y < env->map->rows - 1)
//             {
//                 int z_down = env->map->data[y + 1][x];
//                 isometric(x, y + 1, z_down, env, &x1, &y1);
//                 draw_gradient_line(env, x0, y0, x1, y1, z, z_down);
//             }
//         }
//     }
// }


// /*
//  * parse_map(): 指定された .fdf ファイルから地形データを読み込み、t_map 構造体に格納して返す。
//  */
// t_map *parse_map(const char *filename)
// {
//     FILE *file;
//     char *line = NULL;
//     size_t len = 0;
//     ssize_t read;
//     int rows = 0, cols = 0;
//     t_map *map;
//     int **data;
//     int i, j;

//     file = fopen(filename, "r");
//     if (!file)
//         return NULL;

//     // 一度全行を読み、各行のトークン数を正確にカウントする
//     // （ここでは ft_split を使った例）
//     char **tokens;
//     while ((read = getline(&line, &len, file)) != -1)
//     {
//         tokens = ft_split(line, ' ');
//         if (!tokens)
//             break;
//         int token_count = 0;
//         while (tokens[token_count])
//             token_count++;
//         if (rows == 0)
//             cols = token_count;
//         else if (cols != token_count)
//         {
//             // 行ごとのトークン数が一致しなければエラー処理
//             free_tokens(tokens);
//             fclose(file);
//             if (line)
//                 free(line);
//             return NULL;
//         }
//         free_tokens(tokens);
//         rows++;
//     }
//     // 行数がゼロの場合はエラー
//     if (rows == 0)
//     {
//         fclose(file);
//         if (line)
//             free(line);
//         return NULL;
//     }

//     // メモリの確保
//     map = malloc(sizeof(t_map));
//     map->rows = rows;
//     map->cols = cols;
//     data = malloc(sizeof(int *) * rows);
//     for (i = 0; i < rows; i++)
//         data[i] = malloc(sizeof(int) * cols);

//     fseek(file, 0, SEEK_SET);
//     i = 0;
//     while ((read = getline(&line, &len, file)) != -1 && i < rows)
//     {
//         tokens = ft_split(line, ' ');
//         if (!tokens)
//             break;
//         for (j = 0; j < cols; j++)
//         {
//             if (tokens[j])
//                 data[i][j] = atoi(tokens[j]);
//             else
//                 data[i][j] = 0;  // あるいはエラー処理
//         }
//         free_tokens(tokens);
//         i++;
//     }
//     map->data = data;
//     fclose(file);
//     if (line)
//         free(line);
//     return map;
// }

// /*
//  * free_map(): parse_map() で確保したメモリを解放する
//  */
// void free_map(t_map *map)
// {
//     int i;
//     for (i = 0; i < map->rows; i++)
//         free(map->data[i]);
//     free(map->data);
//     free(map);
// }

// void free_tokens(char **tokens)
// {
//     int i = 0;

//     if (!tokens)
//         return;
//     while (tokens[i])
//     {
//         free(tokens[i]);
//         i++;
//     }
//     free(tokens);
// }

// /*
//  * main(): プログラムのエントリーポイント
//  * ・引数で指定された .fdf ファイルから地形データを読み込み、
//  * ・MiniLibX でウィンドウを生成し、初期の描画とイベントハンドラの登録を行う。
//  */
// int main(int argc, char **argv)
// {
//     t_env env;

//     if (argc != 2)
//     {
//         fprintf(stderr, "Usage: %s <map_file>\n", argv[0]);
//         return (1);
//     }
//     env.map = parse_map(argv[1]);
//     if (!env.map)
//     {
//         fprintf(stderr, "Error reading the map\n");
//         return (1);
//     }
//     env.mlx = mlx_init();
//     env.win = mlx_new_window(env.mlx, WIDTH, HEIGHT, "FDF");
//     env.angle = 0;           // Y軸周りの回転角度（度）- 初期状態は30度+この値
//     env.angle_x = 0;         // X軸周りの回転角度（度）- 初期状態は30度+この値
//     env.offset_x = WIDTH / 2; // X方向の初期オフセット（画面中央に配置）
//     env.offset_y = HEIGHT / 4;// Y方向の初期オフセット
//     mlx_hook(env.win, 2, 1L<<0, key_hook, &env);
//     draw_map(&env);
//     mlx_loop(env.mlx);
//     return (0);
// }
