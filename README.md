# Windows Driver

The Windows driver sample.

## Development

These instructions will get you the project up and running on your local machine for development and testing purposes.

### Prerequisites

Following are the minimum requirements for the development of this project.

- A Windows Machine ( Windows 10, version 1809 or higher ) 
- Install [Enterprise WDK](https://learn.microsoft.com/en-us/legal/windows/hardware/enterprise-wdk-license-2017) on path `C:\EWDK`
- Install [Make](https://www.gnu.org/software/make/)
- Have the `DebugView` tool from SysInternals on the Test Machine
- On the test machine, turn off Integrity checks and turn on test signing. This can be done by running the following commands from an Admin prompt and then rebooting the system:

```shell
bcdedit.exe -set loadoptions DISABLE_INTEGRITY_CHECKS
bcdedit.exe -set TESTSIGNING ON
```

### Build

To build the driver, simply run:

```shell
make
```

## Authors

The following people are contributing to this project.

- [@musthafasm](https://github.com/musthafasm)
