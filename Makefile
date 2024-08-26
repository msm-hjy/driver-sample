# Makefile for building Windows driver.
#
# Targets:
#   - make:       Compile and build the driver.
#   - make clean: Cleans up build artifacts.
#	- make test:  Run static code analysis on the driver.

# Define the target name and output directory
TARGETNAME = HelloWorldDriver
TARGETPATH = build
TESTSTPATH = $(TARGETPATH)\tests

# Source and object files
SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c, $(TARGETPATH)/%.obj, $(SOURCES))

# EWDK paths
EWDK_WDK_LIB = $(WDKContentRoot)Lib\$(Version_Number)
EWDK_WDK_INCLUDE = $(WDKContentRoot)Include\$(Version_Number)

# Compiler include directories
COMPILER_DIRS = /I"$(EWDK_WDK_INCLUDE)\shared" /I"$(EWDK_WDK_INCLUDE)\um" /I"$(EWDK_WDK_INCLUDE)\km" /I"$(EWDK_WDK_INCLUDE)\ucrt" /I"$(EWDK_WDK_INCLUDE)\winrt"
COMPILER_DIRS += /I "$(VCToolsInstallDir)include" /I "$(VCToolsInstallDir)atlmfc\include"

# Compiler flags
COMPILER_FLAGS = $(COMPILER_DIRS)
COMPILER_FLAGS += /D _AMD64_ /D _WIN64 /D NTDDI_VERSION=0x0A000000 /D WINVER=0x0A00 /D _WIN32_WINNT=0x0A00 \
	/D _UNICODE /D UNICODE /D _WDM_DRIVER /D _KERNEL_MODE /nologo /W4

# Linker include directories
LINKER_DIRS = /LIBPATH:"$(EWDK_WDK_LIB)\km\x64"
LINKER_DIRS += /LIBPATH:"$(EWDK_WDK_LIB)\um\x64"
LINKER_DIRS += /LIBPATH:"$(EWDK_WDK_LIB)\ucrt\x64"

# Linker flags
LINKER_FLAGS = $(LINKER_DIRS)
LINKER_FLAGS += /DRIVER /DRIVER:WDM /SUBSYSTEM:NATIVE /RELEASE /INCREMENTAL:NO /ENTRY:DriverEntry /nologo \
	/PDBALTPATH:$(TARGETPATH)/$(TARGETNAME).pdb /MAP:$(TARGETPATH)/$(TARGETNAME).map

ANALYZE_FLAGS = $(COMPILER_FLAGS)
ANALYZE_FLAGS += /analyze /WX- /external:W0 /experimental:external

# Default rule
all: build

# Build the driver
build:
	@if not exist $(TARGETPATH) mkdir $(TARGETPATH)
	@echo Compiling source files...
	@CL $(COMPILER_FLAGS) /Fo$(TARGETPATH)\ /c $(SOURCES)
	@echo Linking object files...
	@LINK $(LINKER_FLAGS) /OUT:$(TARGETPATH)/$(TARGETNAME).sys $(OBJECTS)

# Clean up build artifacts
clean:
	@echo Cleaning up build artifacts...
	@if exist build rd /s /q build

test:
	@echo Running tests...
	@if not exist $(TESTSTPATH) mkdir $(TESTSTPATH)
	@CL $(ANALYZE_FLAGS) /Fo$(TESTSTPATH)\ /c $(SOURCES)
