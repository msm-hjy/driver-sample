# Define the target name and output directory
TARGETNAME=HelloWorldDriver
TARGETPATH=build

# Specify the source files
SOURCES=src\HelloWorldDriver.c

# Create the build directory if it doesn't exist
all:
    if not exist $(TARGETPATH) mkdir $(TARGETPATH)
    cl /EHsc /Fo$(TARGETPATH)\ /c $(SOURCES)
    link /OUT:$(TARGETPATH)\$(TARGETNAME).sys $(TARGETPATH)\HelloWorldDriver.obj
