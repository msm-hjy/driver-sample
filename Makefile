# Makefile for building Windows driver.
#
# Targets:
#   - make:       Compile and build the driver.
#   - make clean: Cleans up build artifacts.

# Define the target name and output directory
TARGETNAME = HelloWorldDriver
TARGETPATH = build

# EWDK paths and tools
EWDK_ROOT = C:/EWDK/Program Files
EWDK_WDK_LIB = $(EWDK_ROOT)/Windows Kits/10/Lib/10.0.17763.0
EWDK_WDK_INCLUDE = $(EWDK_ROOT)/Windows Kits/10/Include/10.0.17763.0
EWDK_MSVC_ROOT = $(EWDK_ROOT)/Microsoft Visual Studio/2017/BuildTools/VC/Tools/MSVC/14.15.26726

# Paths to compiler and linker
COMPILER = $(EWDK_MSVC_ROOT)/bin/Hostx64/x64/cl.exe
LINKER = $(EWDK_MSVC_ROOT)/bin/Hostx64/x64/link.exe

# Compiler include directories
COMPILER_DIRS = /I"$(EWDK_WDK_INCLUDE)/shared" /I"$(EWDK_WDK_INCLUDE)/um" /I"$(EWDK_WDK_INCLUDE)/km" /I"$(EWDK_WDK_INCLUDE)/ucrt" /I"$(EWDK_WDK_INCLUDE)/winrt"
COMPILER_DIRS += /I "$(EWDK_MSVC_ROOT)/include" /I "$(EWDK_MSVC_ROOT)/atlmfc/include"

# Compiler flags
COMPILER_FLAGS = /EHsc $(COMPILER_DIRS)
COMPILER_FLAGS += /D _AMD64_ /D _WIN64 /D NTDDI_VERSION=0x0A000000 /D WINVER=0x0A00 /D _WIN32_WINNT=0x0A00 /D _UNICODE /D UNICODE /D _WDM_DRIVER /D _KERNEL_MODE

# Linker include directories
LINKER_DIRS = /LIBPATH:"$(EWDK_WDK_LIB)/km/x64" ntoskrnl.lib
LINKER_DIRS += /LIBPATH:"$(EWDK_WDK_LIB)/um/x64" uuid.lib
LINKER_DIRS += /LIBPATH:"$(EWDK_WDK_LIB)/ucrt/x64" ucrt.lib

# Linker flags
LINKER_FLAGS = $(LINKER_DIRS)
LINKER_FLAGS += /DRIVER /DRIVER:WDM /SUBSYSTEM:NATIVE /RELEASE /INCREMENTAL:NO /ENTRY:DriverEntry
LINKER_FLAGS += /DEBUG /DEBUGTYPE:CV /PDBALTPATH:$(TARGETPATH)/$(TARGETNAME).pdb
LINKER_FLAGS += /MAP:$(TARGETPATH)/$(TARGETNAME).map

# Source and object files
SOURCES = $(wildcard src/*.c)
OBJECTS = $(patsubst src/%.c, $(TARGETPATH)/%.obj, $(SOURCES))

# Default rule
all:
	if not exist $(TARGETPATH) mkdir $(TARGETPATH)
	$(COMPILER) $(COMPILER_FLAGS) /Fo$(TARGETPATH)\ /c $(SOURCES)
	$(LINKER) $(LINKER_FLAGS) /OUT:$(TARGETPATH)/$(TARGETNAME).sys $(OBJECTS)

# Clean up build artifacts
clean:
	if exist build rd /s /q build
