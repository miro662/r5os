# R5OS

bare-metal experiments with VisionFive 2

## How to run

r5os uses LLVM to be built. You can build `r5os` using make:

```
make
```

Then, you have many ways to run it on VisionFive 2:

### Using tftp

In order to do this, you need to connect your VisionFive 2 to network where it can access a TFTP server. Then:

1) Host a `build/r5os.elf` on your TFTP server.
2) Connect to your VisionFive 2 by UART (using e.g. minicom or putty).
3) Run your VisionFive 2 and get to u-boot prompt. You can do this by running your VisionFive 2 without any storage medium or interrupting start-up when U-boot lists available images.
4) Configure network. You can use command `dhcp`:
```
StarFive # dhcp
```
or manually assign address by setting `ipaddr` and `netmask` using `setenv`:
```
StarFive # setenv ipaddr 192.168.0.100
StarFive # setenv netmask 255.255.255.0
```
5) Load `r5os.elf` file from TFTP server:
```
StarFive # tftpboot ${loadAddr} [tftpServerAddr]:[pathToR5OsElf]
```
6) r5os.elf is now loaded at `loadAddr` (0x60000000). Run it with command `bootelf`:
```
StarFive # bootelf
```

### Using ymodem

In order to do this, you need to connect to your VisionFive 2 by UART and use program capable of transfering files via ymodem (e.g. minicom). Then:

1) Run your VisionFive 2 and get to u-boot prompt. You can do this by running your VisionFive 2 without any storage medium or interrupting start-up when U-boot lists available images.
2) Enter `loady` command:
```
StarFive # loady
```
3) Begin transfering file. In minicom, press `Ctrl+A` and then `S`. A menu should open - select `ymodem`, and then navigate to `build/r5os.elf`. Wait a while until transfer is complete and prompt appears.
4) r5os.elf is now loaded at `loadAddr` (0x60000000). Run it with command `bootelf`:
```
StarFive # bootelf
```