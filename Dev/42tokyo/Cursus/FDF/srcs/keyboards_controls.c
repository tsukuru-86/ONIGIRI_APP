/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   keyboards_controls.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-02-27 10:51:20 by tsukuru           #+#    #+#             */
/*   Updated: 2025-02-27 10:51:20 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../FDF.h"

/*
 * key_hook(): キーボードイベント処理
 * ESC: 終了
 * 矢印キー: 平行移動
 * WASD: 3Dモデルの回転
 *   - W/S: X軸周りの回転（前後）
 *   - A/D: Y軸周りの回転（左右）
 */
int key_hook(int keycode, t_env *env)
{
    if (keycode == 53)  // ESC キー
    {
        free_map(env->map);
        mlx_destroy_window(env->mlx, env->win);
        exit(0);
    }
    else if (keycode == 123)  // 左矢印キー
        env->offset_x -= 10;
    else if (keycode == 124)  // 右矢印キー
        env->offset_x += 10;
    else if (keycode == 126)  // 上矢印キー
        env->offset_y -= 10;
    else if (keycode == 125)  // 下矢印キー
        env->offset_y += 10;
    else if (keycode == 0)   // Aキー: 左回転
        env->angle -= 5;
    else if (keycode == 2)   // Dキー: 右回転
        env->angle += 5;
    else if (keycode == 13)  // Wキー: 前回転
        env->angle_x -= 5;
    else if (keycode == 1)   // Sキー: 後回転
        env->angle_x += 5;
    draw_map(env);
    return (0);
}