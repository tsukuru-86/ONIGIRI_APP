/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: tsukuru <tsukuru@student.42.fr>            #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-04-04 13:55:04 by tsukuru           #+#    #+#             */
/*   Updated: 2025-04-04 13:55:04 by tsukuru          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/get_next_line.h"
#include <fcntl.h>

// NULLポインタをチェックして安全に結合する関数
char	*ft_connect(int fd, char *buff, char *temp, char *leftover)
{
	int	read_bytes;

	read_bytes = 1;
	while ((!leftover || !ft_strchr(leftover, '\n')) && read_bytes > 0)
	{
		read_bytes = read(fd, buff, BUFFER_SIZE);
		if (read_bytes <= 0)
			break ;
		buff[read_bytes] = '\0';
		// leftoverがNULLの場合、新しい文字列を作成
		if (!leftover)
		{
			leftover = ft_strdup(buff);
			if (!leftover)
			{
				free(buff);
				return (NULL);
			}
		}
		else
		{
			temp = ft_strjoin(leftover, buff);
			if (!temp)
			{
				free(buff);
				return (NULL);
			}
			free(leftover);
			leftover = temp;
		}
	}
	free(buff);
	return (leftover);
}

static char	*ft_read_to_leftover(int fd, char *leftover)
{
	char	*buff;
	char	*temp;

	buff = (char *)malloc((BUFFER_SIZE + 1) * sizeof(char));
	if (!buff)
		return (NULL);
	temp = NULL;
	leftover = ft_connect(fd, buff, temp, leftover);
	return (leftover);
}

char	*ft_get_line(char *leftover)
{
	int		i;
	char	*line;

	i = 0;
	if (!leftover)
		return (NULL);
	while (leftover[i] && leftover[i] != '\n')
		i++;
	line = (char *)malloc(sizeof(char) * (i + 2));
	if (!line)
		return (NULL);
	i = 0;
	while (leftover[i] && leftover[i] != '\n')
	{
		line[i] = leftover[i];
		i++;
	}
	if (leftover[i] == '\n')
	{
		line[i] = leftover[i];
		i++;
	}
	line[i] = '\0';
	return (line);
}

static char	*ft_new_leftover(char *leftover)
{
	int		i;
	int		j;
	char	*new_leftover;

	i = 0;
	j = 0;
	new_leftover = NULL;
	if (!leftover)
		return (NULL);
	while (leftover[i] && leftover[i] != '\n')
		i++;
	if (!leftover[i]) // 改行文字がない場合
	{
		free(leftover);
		return (NULL);
	}
	// ft_strlen が NULL に対して呼ばれないよう修正
	new_leftover = (char *)malloc(sizeof(char) * (ft_strlen(leftover) - i + 1));
	if (!new_leftover)
	{
		free(leftover);
		return (NULL);
	}
	i++; // 改行文字をスキップ
	while (leftover[i])
		new_leftover[j++] = leftover[i++];
	new_leftover[j] = '\0';
	free(leftover);
	return (new_leftover);
}

char	*get_next_line(int fd)
{
	static char	*leftover;
	char		*line;

	if (fd < 0 || BUFFER_SIZE <= 0)
		return (NULL);
	leftover = ft_read_to_leftover(fd, leftover);
	if (!leftover || leftover[0] == '\0')
	{
		free(leftover);
		leftover = NULL;
		return (NULL);
	}
	line = ft_get_line(leftover);
	leftover = ft_new_leftover(leftover);
	return (line);
}