/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   isometric.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 07:40:34 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 07:40:34 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

/**
 * マップの中心座標を計算
 */
 void	get_center(t_env *env, double *center_x, double *center_y)
 {
     *center_x = (double)(env->map->cols - 1) / 2.0;
     *center_y = (double)(env->map->rows - 1) / 2.0;
 }
 
//  /**
//   * アイソメトリック座標の計算
//   */
//  void	calculate_iso_coords(double rx, double ry, double rz,
//          t_env *env, int *iso_x, int *iso_y)
//  {
//      double	iso_angle;
 
//      iso_angle = 30.0 * (M_PI / 180.0);
//      *iso_x = round((rx - ry) * cos(iso_angle) * env->scale + env->offset_x);
//      *iso_y = round((rx + ry) * sin(iso_angle) * env->scale - rz + env->offset_y);
//  }

void calculate_iso_coords(double rx, double ry, double rz,
    t_env *env, int *iso_x, int *iso_y)
{
    double iso_angle;

    iso_angle = 30.0 * (M_PI / 180.0);
    *iso_x = round((rx - ry) * cos(iso_angle) * env->scale + env->offset_x);
    // スケーリングを均等に適用
    *iso_y = round(((rx + ry) * sin(iso_angle) - rz) * env->scale + env->offset_y);
}

/**
 * isometric(): 3D座標 (x, y, z) をアイソメトリック投影し、直感的な回転を適用して
 * 画面上の座標 (iso_x, iso_y) に変換する。
 */
 void	isometric(int x, int y, int z, t_env *env, int *iso_x, int *iso_y)
 {
     double	center_x;
     double	center_y;
     double	rx;
     double	ry;
     double	rz;
 
     get_center(env, &center_x, &center_y);
     rx = x - center_x;
     ry = y - center_y;
     rz = (double)z * ALT;
     rotate_point(&rx, &ry, &rz, env);
     calculate_iso_coords(rx, ry, rz, env, iso_x, iso_y);
 }