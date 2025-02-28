# プログラム名
NAME = fdf

# ディレクトリ設定
SRC_DIR = srcs
MLX_DIR = minilibx
INC_DIR = includes
LIBFT_DIR = libft
LIBFT_INC = $(LIBFT_DIR)/includes

# コンパイラとフラグ設定
CC = gcc
CFLAGS = -Wall -Wextra -Werror -I$(MLX_DIR) -I$(INC_DIR) -I$(LIBFT_INC)

# MinilibXライブラリとリンクオプション
MLX_LIB = $(MLX_DIR)/libmlx.a
MLX_LIBS = -L$(MLX_DIR) -lmlx -framework OpenGL -framework AppKit

# libft のライブラリファイル
LIBFT = $(LIBFT_DIR)/libft.a
LIBFT_LIBS = -L$(LIBFT_DIR) -lft

# ソースファイルとオブジェクトファイルのリスト
SRCS = $(wildcard $(SRC_DIR)/*.c)
OBJS = $(SRCS:.c=.o)

# デフォルトターゲット
all: $(NAME)

# libft と MinilibX ライブラリが無い場合はビルド
$(LIBFT):
	$(MAKE) -C $(LIBFT_DIR)

$(MLX_LIB):
	$(MAKE) -C $(MLX_DIR)

# プログラムのリンク
$(NAME): $(OBJS) $(MLX_LIB) $(LIBFT)
	$(CC) $(CFLAGS) -o $@ $^ $(MLX_LIBS) $(LIBFT_LIBS)

# 各ソースファイルのコンパイル
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# オブジェクトファイルの削除
clean:
	rm -f $(OBJS)
	$(MAKE) clean -C $(MLX_DIR)
	$(MAKE) clean -C $(LIBFT_DIR)

# プログラム実体とオブジェクトファイルを全て削除
fclean: clean
	rm -f $(NAME)
	$(MAKE) clean -C $(MLX_DIR)
	$(MAKE) clean -C $(LIBFT_DIR)

# リビルド（再構築）
re: fclean all

.PHONY: all clean fclean re