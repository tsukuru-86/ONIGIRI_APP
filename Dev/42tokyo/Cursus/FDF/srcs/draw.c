/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   draw.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 07:28:27 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 07:28:27 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

/**
 * 右隣りの点との線を描画
 */
 void	draw_right_connection(t_env *env, int x, int y, int z)
 {
     int	x0;
     int	y0;
     int	x1;
     int	y1;
     int	z_right;
 
     if (x < env->map->cols - 1)
     {
         z_right = env->map->data[y][x + 1];
         isometric(x, y, z, env, &x0, &y0);
         isometric(x + 1, y, z_right, env, &x1, &y1);
         draw_gradient_line(env, x0, y0, x1, y1, z, z_right);
     }
 }
 
 /**
  * 下の点との線を描画
  */
 void	draw_down_connection(t_env *env, int x, int y, int z)
 {
     int	x0;
     int	y0;
     int	x1;
     int	y1;
     int	z_down;
 
     if (y < env->map->rows - 1)
     {
         z_down = env->map->data[y + 1][x];
         isometric(x, y, z, env, &x0, &y0);
         isometric(x, y + 1, z_down, env, &x1, &y1);
         draw_gradient_line(env, x0, y0, x1, y1, z, z_down);
     }
 }

void draw_map(t_env *env)
{
    int x;
    int y;
    int z;

    mlx_clear_window(env->mlx, env->win);
    y = 0;
    while (y < env->map->rows)
    {
        x = 0;
        while (x < env->map->cols)
        {
            z = env->map->data[y][x];
            draw_right_connection(env, x, y, z);
            draw_down_connection(env, x, y, z);
            x++;
        }
        y++;
    }
}