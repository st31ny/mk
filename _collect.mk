####################################################################################################
## vim:set ft=make: ################################################################################
## ADS Build System ################################################################################
## Copyright (C) 2017 Maximilian Stein #############################################################
####################################################################################################
## Collect Makefile Fragment #######################################################################
## Aggregate local source files ####################################################################
####################################################################################################

## Build list of local object files
# evaluate rhs immediately and dirctly merge build-specific files
# unset local variables (avoid side effects when unused)

# c++
__SRC_CXX               := $(addprefix $(MYDIR)/,$(SRC_CXX)) $(addprefix $(MYDIR)/,$(SRC_CXX_$(BUILD)))
__OBJ_CXX               := $(patsubst %,$(OBJDIR.$(PKG))/cxx/%.o,$(__SRC_CXX))
SRC_CXX                 :=
SRC_CXX_$(BUILD)        :=

# c
__SRC_C                 := $(addprefix $(MYDIR)/,$(SRC_C)) $(addprefix $(MYDIR)/,$(SRC_C_$(BUILD)))
__OBJ_C                 := $(patsubst %,$(OBJDIR.$(PKG))/c/%.o,$(__SRC_C))
SRC_C                   :=
SRC_C_$(BUILD)          :=

# capnp
__SRC_CAPNP             := $(addprefix $(MYDIR)/,$(SRC_CAPNP)) $(addprefix $(MYDIR)/,$(SRC_CAPNP_$(BUILD)))
__OBJ_CAPNP             := $(patsubst %,$(OBJDIR.$(PKG))/capnp/%.o,$(__SRC_CAPNP))
ifneq ($(SRC_CAPNP),)
$(eval CLEAN_FILES      += $(addsuffix .h,$(SRC_CAPNP)) $(addsuffix .c++,$(SRC_CAPNP)))
endif
SRC_CAPNP               :=
SRC_CAPNP_$(BUILD)      :=

## Local object files
__OBJ                   := $(__OBJ_CXX) $(__OBJ_C) $(__OBJ_CAPNP)
