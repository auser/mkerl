PACKAGE_NAME = <%= name %>
PACKAGE_VERSION = 0.1
VSN = $(PACKAGE_VERSION)
ERLC_FLAGS := -W
EBIN_DIR := ./ebin
EMULATOR := beam
ERL = `which erl`
ERLC = `which erlc`
DOC_DIR = ./doc
ERLDIR = $(erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell)
SILENCE = @

ERL_SOURCE_DIRS = \
	./src

TEST_DIRS = \
	./test/src

DEPS_DIRS = \
	./ebin

####### 
## DON'T EDIT BELOW HERE, UNLESS YOU REALLY KNOW WHAT YOU ARE DOING
#######

#Helper Functions
get_src_from_dir  = $(wildcard $1/*.erl)
get_src_from_dir_list = $(foreach dir, $1, $(call get_src_from_dir,$(dir)))
prefix_each_dir = $(foreach dir, $1, -pa $(dir))
src_to_beam = $(subst ./src, ./ebin, $(subst .erl,.beam,$1))
# src_to_beam = $(subst .erl,.beam,$1)

SRC = $(call get_src_from_dir_list, $(ERL_SOURCE_DIRS))
OBJ = $(call src_to_beam,$(SRC))
STUFF_TO_CLEAN += $(OBJ)

TEST_SRC = $(call get_src_from_dir_list, $(TEST_DIRS))
TEST_OBJ = $(call src_to_beam,$(TEST_SRC))
STUFF_TO_CLEAN += $(TEST_OBJ)

PA_EBIN_DIRS = $(call prefix_each_dir, $(DEPS_DIRS))

DOC_FILES = $(DOC_DIR)/*.html $(DOC_DIR)/*.png $(DOC_DIR)/*.css $(DOC_DIR)/edoc-info
STUFF_TO_CLEAN += $(DOC_FILES)

ALL_OBJ = $(OBJ) $(TEST_OBJ)
ALL_SRC = $(SRC) $(TEST_SRC)
 
all: $(OBJ)
	
docs:
	$(SILENCE) $(ERL) -noshell -run edoc_run application "'$(PACKAGE_NAME)'" '"."' '[{def,{vsn,"$(VSN)"}}, {dir, "$(DOC_DIR)"}]'

$(OBJ): $(SRC)
	$(SILENCE)echo compiling $(notdir $@)
	$(SILENCE)$(ERLC) $(ERLC_FLAGS) -I./include -o $(EBIN_DIR) $^

$(TEST_OBJ): $(TEST_SRC)
	$(SILENCE)echo compiling $(notdir $@)
	$(SILENCE)$(ERLC) $(ERLC_FLAGS) -I./include -o $(EBIN_DIR) $^

debug:
	$(MAKE) DEBUG=-DDEBUG
	
test: all $(TEST_OBJ)
	$(SILENCE) $(ERL)	-noshell 	\
					-sname local_test 	\
					$(PA_EBIN_DIRS) 		\
					-s test_suite test 	\
					-s init stop

boot: all
	$(SILENCE) $(ERL) $(PA_EBIN_DIRS) -noshell -run make_boot write_scripts $(PACKAGE_NAME) $(VSN)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).boot $(EBIN_DIR)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).rel $(EBIN_DIR)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).script $(EBIN_DIR)

clean:
	@(rm -rf $(EBIN_DIR)/*.beam erl_crash.dump $(DOC_FILES))
 