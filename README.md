# Windows virtio Paravirtualized Drivers for kvm qemu

## Dependencies

WinDDK (Tested with 7.1)
Microsoft Windows SDK (Tested with v7.1)

## How to build drivers
1. Startup WinDDK free build environment
2. run buildAll.cmd
3. run signAll.cmd to test sign drivers

## FAQ

**Q:** Is the viostor driver safe to use with write-back caching enabled?
**A:** It is **NOT** for version prior to Windows 8. Microsoft Windows does not issue flush operations to ensure transactional consistencies for NTFS metadata. It instead utilizes FUA per each write.  This driver does not respect the FUA bit.
