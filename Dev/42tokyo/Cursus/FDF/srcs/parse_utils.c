/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parce_utils.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 06:08:00 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 06:08:00 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/FDF.h"

int parse_line(char *line, int *row_data, int cols)
{
    char **tokens;
    int i;
    int result;

    tokens = ft_split(line, ' ');
    if (!tokens)
        return 0;
    i = 0;
    result = 1;
    while (tokens[i] && tokens[i][0] != '\n')
    {
        if (i >= cols)
        {
            free_tokens(tokens);
            return 0;
        }
        row_data[i] = ft_atoi(tokens[i]);
        i++;
    }
    if (i != cols)
    {
        free_tokens(tokens);
        return 0;
    }
    free_tokens(tokens);
    return result;
}

void free_tokens(char **tokens)
{
    int i;

    if (!tokens)
        return ;
    i = 0;
    while (tokens[i])
    {
        free(tokens[i]);
        i++;
    }
    free(tokens);
}