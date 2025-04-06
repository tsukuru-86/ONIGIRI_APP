/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   line.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 08:51:20 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 08:51:20 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"
#include <stdlib.h>

/**
 * 線描画のパラメータを初期化する
 */
 void	init_line_params(int *params, int x0, int y0, int x1, int y1)
 {
     params[0] = abs(x1 - x0);
     params[1] = abs(y1 - y0);
     params[2] = (x0 < x1) ? 1 : -1;
     params[3] = (y0 < y1) ? 1 : -1;
     params[4] = params[0] - params[1];
 }
 
 /**
  * 線描画の総ステップ数を計算
  */
 int	get_total_steps(int dx, int dy)
 {
     if (dx > dy)
         return (dx);
     return (dy);
 }
 
 /**
  * 線描画の初期設定
  */
 void	setup_line_drawing(int x0, int y0, int x1, int y1,
         int z0, int z1, int params[5], int *colors)
 {
     init_line_params(params, x0, y0, x1, y1);
     colors[0] = get_color_from_z(z0);
     colors[1] = get_color_from_z(z1);
 }
 
 /**
  * Bresenhamアルゴリズムによる位置更新
  */
 void	update_position(int params[5], int *x0, int *y0)
 {
     int	e2;
 
     e2 = 2 * params[4];
     if (e2 > -params[1])
     {
         params[4] -= params[1];
         *x0 += params[2];
     }
     if (e2 < params[0])
     {
         params[4] += params[0];
         *y0 += params[3];
     }
 }

/**
* draw_gradient_line(): Bresenham のアルゴリズムにより、
* (x0, y0) から (x1, y1) までの直線を描画する。
* 標高の変化に応じて、色をグラデーションで描画
*/
void	draw_gradient_line(t_env *env, int x0, int y0, int x1, int y1,
       int z0, int z1)
{
   int		params[5];
   int		colors[2];
   int		steps[2];
   double	t;
   int		color;

   setup_line_drawing(x0, y0, x1, y1, z0, z1, params, colors);
   steps[0] = get_total_steps(params[0], params[1]);
   steps[1] = 0;
   while (1)
   {
       t = (steps[0] == 0) ? 0.0 : (double)steps[1] / steps[0];
       color = interpolate_color(colors[0], colors[1], t);
       mlx_pixel_put(env->mlx, env->win, x0, y0, color);
       if (x0 == x1 && y0 == y1)
           break ;
       update_position(params, &x0, &y0);
       steps[1]++;
   }
}