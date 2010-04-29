PACKAGE_NAME = <%= name %>
PACKAGE_VERSION = <%= version %>
VSN = $(PACKAGE_VERSION)
EBIN_DIR := ./ebin
ERL = `which erl`
ERLC = `which erlc`
DOC_DIR = ./doc
ERLDIR = $(erl -eval 'io:format("~s~n", [code:lib_dir()])' -s init stop -noshell)
SILENCE = @

####### 
## DON'T EDIT BELOW HERE, UNLESS YOU REALLY KNOW WHAT YOU ARE DOING
#######

DEPS_DIRLIST=$(shell find ./deps -maxdepth 1 -mindepth 1 -type d | tr '\n' ' ')
DEPS_PA_LIST=$(shell for dir in $(DEPS_DIRLIST); do echo "-pa $$dir"; done)
ERLC_FLAGS := -W -pa ./ebin $(PA_EBIN_DIRS)

DOC_FILES = $(DOC_DIR)/*.html $(DOC_DIR)/*.png $(DOC_DIR)/*.css $(DOC_DIR)/edoc-info
STUFF_TO_CLEAN += $(DOC_FILES)
 
all: compile

docs:
	$(SILENCE) $(ERL) -noshell -run edoc_run application "'$(PACKAGE_NAME)'" '"."' '[{def,{vsn,"$(VSN)"}}, {dir, "$(DOC_DIR)"}]'

compile:
	$(SILENCE)erl -pa ./ebin $(DEPS_PA_LIST) -make
	
debug:
	$(MAKE) DEBUG=-DDEBUG
	
test: all $(TEST_OBJ)
	$(SILENCE) $(ERL)	$(ERLC_FLAGS) \
				-pa ./test/ebin/ \
				-noshell 	\
				-sname local_test 	\
				-s test_suite test 	\
				-s init stop

boot: all
	$(SILENCE) $(ERL) $(ERLC_FLAGS) -noshell -run make_boot write_scripts $(PACKAGE_NAME) $(VSN)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).boot $(EBIN_DIR)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).rel $(EBIN_DIR)
	$(SILENCE) mv $(PACKAGE_NAME)-$(VSN).script $(EBIN_DIR)

clean:
	@(rm -rf $(EBIN_DIR)/*.beam erl_crash.dump $(DOC_FILES))
