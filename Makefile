# **************************************************************************** #
#	VARIABLES																   #
# **************************************************************************** #

NAME = inception

DIR_SRC = ./srcs

COMPOSE_FILE = $(DIR_SRC)/docker-compose.yml

# **************************************************************************** #
#	RULES																	   #
# **************************************************************************** #

all: $(NAME)

$(NAME): up

up:
	@mkdir -p ~/data/mariadb
	@mkdir -p ~/data/wordpress
	@docker compose -p $(NAME) -f $(COMPOSE_FILE) up || ( printf $(BLUE)"MAKEFILE NOTE: perhaps you haven't started docker?\n"$(RESET); exit 1 )
	@printf $(BLUE)"$(NAME) started!\n"$(RESET)

down:
	@docker compose -f $(COMPOSE_FILE) down
	@printf $(RED)"Inception stopped.\n"$(RESET)

re:
	mkdir -p ~/data/mariadb
	mkdir -p ~/data/wordpress
	@docker compose -p $(NAME) -f $(COMPOSE_FILE) up --build
	@printf $(BLUE)"$(NAME) started!\n"$(RESET)

.PHONY: all up down re

# **************************************************************************** #
#	TEXT MODIFIERS / FORMATITING CODES										   #
# **************************************************************************** #

RED =				"\e[31m"
GREEN =				"\e[32m"
YELLOW =			"\e[33m"
BLUE =				"\e[34m"
MAGENTA =			"\e[35m"
CYAN =				"\e[36m"
LIGHTGRAY =			"\e[37m"
DARKGRAY =			"\e[90m"
LIGHTRED =			"\e[91m"
LIGHTGREEN =		"\e[92m"
LIGHTYELLOW =		"\e[93m"
LIGHTBLUE =			"\e[94m"
LIGHTMAGENTA =		"\e[95m"
LIGHTCYAN =			"\e[96m"
RED_BG =			"\e[41m"
GREEN_BG =			"\e[42m"
YELLOW_BG =			"\e[43m"
BLUE_BG =			"\e[44m"
MAGENTA_BG =		"\e[45m"
CYAN_BG =			"\e[46m"
LIGHTGRAY_BG =		"\e[47m"
DARKGRAY_BG =		"\e[100m"
LIGHTRED_BG =		"\e[101m"
LIGHTGREEN_BG =		"\e[102m"
LIGHTYELLOW_BG =	"\e[103m"
LIGHTBLUE_BG =		"\e[104m"
LIGHTMAGENTA_BG =	"\e[105m"
LIGHTCYAN_BG =		"\e[106m"
BOLD =				"\e[1m"
ITALIC =			"\e[3m"
UNDERLINED =		"\e[4m"
RESET =				"\e[0m"
SPACE =				"\e[50C"