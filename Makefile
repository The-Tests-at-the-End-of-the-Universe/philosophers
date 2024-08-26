include ../tests/config.sh

#Compiler and Linker
CC          := cc $(DEBUG_FLAGS)

#The Target Binary Program
TARGET      := philo

#The Directories, Source, Includes, Objects, Binary and Resources
SRCDIR      := ../philo/
OBJDIR      := ../philo/build/obj
TARGETDIR   := .
BUILDIR     := ../philo/build
RESDIR      := res
SRCEXT      := c
OBJEXT      := o

#Flags, Libraries and Includes
CFLAGS      := $(include_inc) -Wall -Werror -Wextra 

DEBUG_FLAGS := -fsanitize=thread -g3


#---------------------------------------------------------------------------------
#DO NOT EDIT BELOW THIS LINE
#---------------------------------------------------------------------------------
SOURCES     := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS     := $(patsubst $(SRCDIR)/%,$(OBJDIR)/%,$(SOURCES:.$(SRCEXT)=.$(OBJEXT)))

#Default Make

all: $(TARGETDIR)/$(TARGET) 

#Remake
re: fclean all

#Clean only Objects
clean:
	@$(RM) $(OBJECTS)

#Full Clean, Objects and Binaries
fclean: clean
	@$(RM) -rf $(TARGET)

#Link
$(TARGETDIR)/$(TARGET) : $(OBJECTS)
	$(CC) $(OBJECTS) -o  $(TARGETDIR)/$(TARGET) $(DEBUG_FLAGS)

#Compile
$(OBJDIR)/%.$(OBJEXT): $(SRCDIR)/%.$(SRCEXT)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $^ 

#Non-File Targets
.PHONY: all re clean fclean

