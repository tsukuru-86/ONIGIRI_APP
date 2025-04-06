/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rotation.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 08:52:59 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 08:52:59 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

/**
 * Y軸周りの回転
 */
 void	rotate_y(double *rx, double *ry, double angle_y)
 {
     double	temp_x;
     double	temp_y;
 
     temp_x = *rx;
     temp_y = *ry;
     *rx = temp_x * cos(angle_y) - temp_y * sin(angle_y);
     *ry = temp_x * sin(angle_y) + temp_y * cos(angle_y);
 }
 
 /**
  * X軸周りの回転
  */
 void	rotate_x(double *ry, double *rz, double angle_x)
 {
     double	temp_y;
     double	temp_z;
 
     temp_y = *ry;
     temp_z = *rz;
     *ry = temp_y * cos(angle_x) - temp_z * sin(angle_x);
     *rz = temp_y * sin(angle_x) + temp_z * cos(angle_x);
 }
 
 /**
  * 点の回転を計算
  */
 void	rotate_point(double *rx, double *ry, double *rz, t_env *env)
 {
     double	angle_y;
     double	angle_x;
 
     angle_y = env->angle * (M_PI / 180.0);
     angle_x = env->angle_x * (M_PI / 180.0);
     rotate_y(rx, ry, angle_y);
     rotate_x(ry, rz, angle_x);
 }
