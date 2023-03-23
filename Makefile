NAME = inception

ifeq ( , $(findstring .dockerenv, $(ISDOCKER)))
	CC = c++
else
	CC = g++
endif

CC_FLAGS = -Wall -Wextra -Werror -std=c++98 -g

DIR_OBJ = objs/

DIR_SRC = srcs/

DIR_CGI_SRC = cgi-bin/cgi-src/

DIR_CGI_OBJ = cgi-bin/

SRC := $(shell find $(DIR_SRC) -name "*.cpp")

OBJ := $(patsubst $(DIR_SRC)%.cpp, $(DIR_OBJ)%.o, $(SRC))

CGI_SRC := $(shell find $(DIR_CGI_SRC) -name "*.cpp")

CGI_OBJ := $(patsubst $(DIR_CGI_SRC)%.cpp, $(DIR_CGI_OBJ)%.cgi, $(CGI_SRC))

INCLUDE := -I./inc/

# **************************************************************************** #
#	RULES																	   #
# **************************************************************************** #

all: $(CGI_OBJ) $(NAME)

$(NAME): $(OBJ)
	@printf $(BLUE)"Linking objects to a binary file\r"$(RESET)
	@$(CC) $(CC_FLAGS) $(INCLUDE) $^ -o $@
	@printf $(SPACE)$(GREEN)"[✓]\n"$(RESET)
	@printf $(GREEN)$(BOLD)"\t\tCOMPLETE!\n\n"$(RESET)
	@printf $(MAGENTA)"\t\tName of executable: "$(RESET)$(BOLD)$(MAGENTA_BG)" $(NAME) "$(RESET)"\n\n"

$(DIR_OBJ)%.o:	$(DIR_SRC)%.cpp
	@mkdir -p $(dir $@)
	@printf $(BLUE)$(BOLD)"\rCompiling: "$(CYAN)"$(notdir $<)\r"
	@$(CC) $(CC_FLAGS) $(INCLUDE) -c $< -o $@
	@printf $(SPACE)$(GREEN)"[✓]\n"$(RESET)

$(DIR_CGI_OBJ)%.cgi:	$(DIR_CGI_SRC)%.cpp
	@printf $(BLUE)$(BOLD)"\rCompiling: "$(CYAN)"$(notdir $<)\r"
	@$(CC) $< -o $@
	@printf $(SPACE)$(GREEN)"[✓]\n"$(RESET)

install:
	@pip3 --disable-pip-version-check install bs4 > /dev/null
	@pip3 --disable-pip-version-check install requests > /dev/null
	@brew install siege
	@printf $(CYAN)$(BOLD)"Required packages installed [✓]\n"$(RESET)

clean:
	@printf $(MAGENTA)"Removing object files...\r"$(RESET)
	@rm -rf $(DIR_OBJ)
	@printf $(SPACE)$(GREEN)"[✓]\n"$(RESET)

fclean: clean
	@printf $(MAGENTA)"Removing binary file...\r"$(RESET)
	@rm -rf $(NAME)
	@rm -rf $(CGI_OBJ)
	@printf $(SPACE)$(GREEN)"[✓]\n\n"$(RESET)

re: fclean all

exe:
#	export PYTHONPATH="`python3 -m site --user-base`/lib/python/site-packages"
	./$(NAME)

run: all exe

.PHONY: all clean fclean re exe

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