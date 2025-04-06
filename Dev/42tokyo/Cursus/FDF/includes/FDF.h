#ifndef FDF_H
#define FDF_H

#include "../libft/libft.h"
#include "get_next_line.h"
#include "../minilibx/mlx.h"
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <math.h>
#include <fcntl.h>
#include <string.h>

# define WIDTH 1200
# define HEIGHT 800
# define SCALE 20
# define ALT 0.5

typedef struct s_map
{
	int	**data;
	int	rows;
	int	cols;
}	t_map;

typedef struct s_point
{
	int	x;
	int	y;
	int	z;
	int	color;
}	t_point;

typedef struct s_env
{
	void	*mlx;
	void	*win;
	t_map	*map;
	double	angle;
	double	angle_x;
	int		offset_x;
	int		offset_y;
	double	scale;
}	t_env;

/* main.c */
void	init_env(t_env *env);

/* parse.c */
t_map	*parse_map(char *filename);
int		count_rows_and_cols(char *filename, int *cols);

/* parse_utils.c */
int		parse_line(char *line, int *row_data, int cols);
void	free_tokens(char **tokens);

/* map_allocation.c */
t_map	*allocate_map_structure(int rows, int cols);
int		allocate_map_data(t_map *map);
int		read_map_data(t_map *map, int fd);
void	free_map(t_map *map);

/* draw.c */
void	draw_map(t_env *env);

/* draw_connections.c */
void	draw_right_connection(t_env *env, int x, int y, int z);
void	draw_down_connection(t_env *env, int x, int y, int z);

/* isometric.c */
void	isometric(int x, int y, int z, t_env *env, int *iso_x, int *iso_y);

/* rotation.c */
void	rotate_y(double *rx, double *ry, double angle_y);
void	rotate_x(double *ry, double *rz, double angle_x);
void	rotate_point(double *rx, double *ry, double *rz, t_env *env);

/* iso_utils.c */
void	get_center(t_env *env, double *center_x, double *center_y);
void	calculate_iso_coords(double rx, double ry, double rz,
			t_env *env, int *iso_x, int *iso_y);

/* color.c */
int		get_color_from_z(int z);
void	extract_colors(int color, int *r, int *g, int *b);
int		combine_rgb(int r, int g, int b);

/* color_utils.c */
int		interpolate_color(int color_start, int color_end, double t);

/* line.c */
void	draw_gradient_line(t_env *env, int x0, int y0, int x1, int y1, 
			int z0, int z1);

/* line_utils.c */
void	init_line_params(int *params, int x0, int y0, int x1, int y1);
int		get_total_steps(int dx, int dy);
void	setup_line_drawing(int x0, int y0, int x1, int y1,
			int z0, int z1, int params[5], int *colors);
void	update_position(int params[5], int *x0, int *y0);

/* key_hook.c */
int		key_hook(int keycode, t_env *env);
int		close_window(t_env *env);

char	*get_next_line(int fd);

#endif