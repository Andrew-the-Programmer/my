# Windows

1. Hold shift and click on "reboot".
2. Select "Use a divice"
3. Select your USB

# Linux

1. Run `efibootmgr` in terminal
2. Find your USB number (BootXXXX)
3. Set next boot device with `sudo efibootmgr --bootnext XXXX`
4. reboot (`sudo reboot`)