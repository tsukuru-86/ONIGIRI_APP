/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   key_hook.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 08:53:40 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 08:53:40 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

/**
 * ウィンドウのクローズイベント（赤いXボタン）処理
 */
int	close_window(t_env *env)
{
	mlx_destroy_window(env->mlx, env->win);
	free_map(env->map);
	exit(0);
}

/**
 * キー入力に応じたモデルの回転、移動、拡大縮小を行う
 */
int	key_hook(int keycode, t_env *env)
{
	if (keycode == 53)  // ESCキー
	{
		mlx_destroy_window(env->mlx, env->win);
		free_map(env->map);
		exit(0);
	}
	else if (keycode == 0)  // Aキー - 左回転
		env->angle -= 5;
	else if (keycode == 2)  // Dキー - 右回転
		env->angle += 5;
	else if (keycode == 13)  // Wキー - 上回転
		env->angle_x += 5;
	else if (keycode == 1)  // Sキー - 下回転
		env->angle_x -= 5;
	else if (keycode == 126)  // 上矢印 - 上移動
		env->offset_y -= 10;
	else if (keycode == 125)  // 下矢印 - 下移動
		env->offset_y += 10;
	else if (keycode == 123)  // 左矢印 - 左移動
		env->offset_x -= 10;
	else if (keycode == 124)  // 右矢印 - 右移動
		env->offset_x += 10;
	else if (keycode == 24)  // +キー - 拡大
		env->scale *= 1.1;
	else if (keycode == 27)  // -キー - 縮小
		env->scale *= 0.9;
	draw_map(env);
	return (0);
}