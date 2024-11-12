+++
title = "Sainsmart Ham Radio Hotspot"
date = 2021-01-02
[taxonomies]
tags=["hamradio", "hotspot"]
+++

{{ resize_image(path="posts/2021-mmdvm-hotspot/sainsmart_hotspot.jpg", width=150, height=0, op="fit_width") }}

## Introduction

Ham Radio Hotspots have gotten extremely popular. These hotspots allow an
operator to connect to DMR, Yaesu Fusion, and D-Star digital networks without a
local repeater nearby. Many operators build their own hotspot with a Raspberry
Pi, though, recently, I obtained a [Sainsmart
Hotspot](https://www.amazon.com/gp/product/B07JM3WR1G/ref=ppx_yo_dt_b_search_asin_title?ie=UTF8&psc=1)
to try out these digital modes.

## Information

The [manual](Instructions-MMDVMHost-Manual.pdf) is
hard to find. The key information found within the manual are:

* Simplex repeater
* Setting up the wifi
* The radio hardware: `STM32-DVM/MMDVM_HS-Raspberry Pi Hat (GPIO)`.
* The LED setup info: `OLED Type 3` / `/dev/ttyAMA0` / `G4KLX`

## Radio Firmware

Running `pistar-findmodem` is extremely important to figure out which modem
is on your hotspot. Flashing the wrong firmware will leave the modem in a bad
state, though reflashing the correct firmware appears to work.

```sh
# sudo pistar-findmodem
Detected MMDVM_HS (GPIO): /dev/ttyAMA0 (MMDVM_HS_Hat-v1.5.2 20201108 14.7456MHz ADF7021 FW by CA6JAU GitID #89daa20FF37066A3432434257012227)
```

My hotspot has the [MMDVM_HS_Hat v1.5.2 14.7456](https://github.com/juribeparada/MMDVM_HS)
modem and firmware. MMDVM_HS_Hat comes in at least two versions: 14.7456 MHz
or 12.288 MHz. Make sure to note which frequency is yours!

If you have an older version of the firmware it can be upgraded with:

```sh
# sudo pistar-mmdvmhshatflash hs_hat
```

## Usage

Pi-Star allows for multiple digital modes to be enabled. This is a great
feature since it allows us to leverage the different modes. On a simplex
hotspot only one mode can be transmitting or receiving at a time.

### Yaesu Fusion

Most Yaesu radios have built in Fusion or Wires-X buttons. The hotspot might
not register the Wires-X button press, since it polls the modem for which
mode (DMR, D-Star, or Fusion) it should be in.

I have found that keying up for around 1.5 seconds will set the YSF mode, and
then pressing the Wires-X button will work. The RF Hangtime defaults to 20
seconds, and bumping this up to 60 seconds might be beneficial to some.

## Problems

There is still an issue with joining a room. My FT-3D radio shows an FCS room
when joining a YSF room. I opened a [Github
Issue](https://github.com/g4klx/YSFClients/issues/240) to track it.
