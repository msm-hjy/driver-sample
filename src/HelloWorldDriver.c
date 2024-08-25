#include <ntddk.h>

// Forward declaration of UnloadDriver
VOID UnloadDriver(PDRIVER_OBJECT DriverObject);

NTSTATUS DriverEntry(PDRIVER_OBJECT DriverObject, PUNICODE_STRING  RegistryPath)
{
    UNREFERENCED_PARAMETER(RegistryPath);

    DriverObject->DriverUnload = UnloadDriver;

    KdPrint(("Hello, World! Driver Loaded\n"));
    return STATUS_SUCCESS;
}

VOID UnloadDriver(PDRIVER_OBJECT DriverObject)
{
    UNREFERENCED_PARAMETER(DriverObject);

    KdPrint(("Hello, World! Driver Unloaded\n"));
}
