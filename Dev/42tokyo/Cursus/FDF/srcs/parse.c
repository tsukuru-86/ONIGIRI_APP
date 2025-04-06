/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parse.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-02 08:47:26 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-02 08:47:26 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

static int count_cols(char *buffer)
{
    int i;
    int spaces;

    i = 0;
    spaces = 0;
    while (buffer[i] && buffer[i] != '\n')
    {
        if (buffer[i] == ' ' && buffer[i + 1] != ' ' && buffer[i + 1] != '\n')
            spaces++;
        i++;
    }
    return spaces + 1;
}

static int count_rows(int fd)
{
    char *line;
    int row_count;
    
    row_count = 0;
    lseek(fd, 0, SEEK_SET);
    while ((line = get_next_line(fd)))
    {
        if (ft_strchr(line, '0') || ft_strchr(line, '1') || 
            ft_strchr(line, '2') || ft_strchr(line, '3') || 
            ft_strchr(line, '4') || ft_strchr(line, '5') || 
            ft_strchr(line, '6') || ft_strchr(line, '7') || 
            ft_strchr(line, '8') || ft_strchr(line, '9'))
            row_count++;
        free(line);
    }
    lseek(fd, 0, SEEK_SET);
    return row_count;
}

int count_rows_and_cols(char *filename, int *cols)
{
    int fd;
    int rows;
    char buffer[4096];
    int bytes_read;

    fd = open(filename, O_RDONLY);
    if (fd < 0)
        return -1;
    bytes_read = read(fd, buffer, sizeof(buffer) - 1);
    if (bytes_read <= 0)
    {
        close(fd);
        return -1;
    }
    buffer[bytes_read] = '\0';
    *cols = count_cols(buffer);
    lseek(fd, 0, SEEK_SET);  // ファイルポインタを先頭に戻す
    rows = count_rows(fd);
    close(fd);
    return (rows);
}

t_map *parse_map(char *filename)
{
    t_map *map;
    int fd;
    int rows;
    int cols;

    rows = count_rows_and_cols(filename, &cols);
    if (rows <= 0 || cols <= 0)
        return NULL;
    map = allocate_map_structure(rows, cols);
    if (!map)
        return NULL;
    if (!allocate_map_data(map))
    {
        free(map);
        return NULL;
    }
    fd = open(filename, O_RDONLY);
    if (fd < 0 || !read_map_data(map, fd))
    {
        if (fd >= 0)
            close(fd);
        free_map(map);
        return NULL;
    }
    close(fd);
    return map;
}