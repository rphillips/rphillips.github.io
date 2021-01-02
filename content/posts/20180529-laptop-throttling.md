+++
title = "Laptop Throttling"
date = 2018-05-29T15:11:50-05:00
[taxonomies]
tags = [ "laptop", "thinkpad", "t470s" ]
categories = [ "tech" ]
+++

I installed Fedora 28 and Archlinux onto my development machine; a Lenovo
Thinkpad t470s. Generally both distributions ran perfectly fine, but I did run
into a problem on battery power. On battery power my CPUs would not go over 800
Mhz. By plugging in the laptop the CPUs would spin up to their usual 3 Ghz rating.

Then I found this archlinux power management throttling article
[Lenovo_ThinkPad_X1_Carbon_(Gen_6)#Power_management.2FThrottling_issues](https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_6)#Power_management.2FThrottling_issues).
Exactly what I was seeing, but on the t470s.

I installed msr-tools and modprobed the module:

```sh
pacman -S msr-tools
modprobe msr
```

Then ran the wrmsr utility to set the CPU registers manually:

```sh
wrmsr -a 0x1a2 0x3000000 # which sets the offset to 3 C, so the new trip point is 97 C 
```

While on battery power, the CPUs are scaling to their correct clock frequencies.
I suspect this might be a bios issue, since it is happening on the X1 Carbon
_and_ the t470s.
