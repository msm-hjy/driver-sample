#include <ntddk.h>

extern "C" NTSTATUS
DriverEntry(
    _In_ PDRIVER_OBJECT   DriverObject,
    _In_ PUNICODE_STRING  RegistryPath
)
{
    UNREFERENCED_PARAMETER(RegistryPath);

    DriverObject->DriverUnload = UnloadDriver;

    KdPrint(("Hello, World! Driver Loaded\n"));
    return STATUS_SUCCESS;
}

extern "C" VOID UnloadDriver(
    _In_ PDRIVER_OBJECT DriverObject
)
{
    UNREFERENCED_PARAMETER(DriverObject);

    KdPrint(("Hello, World! Driver Unloaded\n"));
}
