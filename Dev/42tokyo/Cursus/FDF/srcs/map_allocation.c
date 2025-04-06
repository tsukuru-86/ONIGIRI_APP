/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   map_allocation.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-02 08:22:51 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-02 08:22:51 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

t_map *allocate_map_structure(int rows, int cols)
{
    t_map *map;

    map = malloc(sizeof(t_map));
    if (!map)
        return NULL;
    map->rows = rows;
    map->cols = cols;
    map->data = NULL;
    return (map);
}

int allocate_map_data(t_map *map)
{
    int i;
    
    map->data = malloc(sizeof(int *) * map->rows);
    if (!map->data)
        return 0;
    i = 0;
    while (i < map->rows)
    {
        map->data[i] = malloc(sizeof(int) * map->cols);
        if (!map->data[i])
        {
            while (--i >= 0)
                free(map->data[i]);
            free(map->data);
            map->data = NULL;
            return 0;
        }
        i++;
    }
    return 1;
}

int read_map_data(t_map *map, int fd)
{
    int row;
    char *line;

    row = 0;
    while (row < map->rows)
    {
        line = get_next_line(fd);
        if (!line)
            break;
        if (!parse_line(line, map->data[row], map->cols))
        {
            free(line);
            return 0;
        }
        free(line);
        row++;
    }
    return 1;
}

void free_map(t_map *map)
{
    int i;

    i = 0;
    while (i < map->rows)
    {
        free(map->data[i]);
        i++;
    }
    free(map->data);
    free(map);
}