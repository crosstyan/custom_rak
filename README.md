# How to run [RAK5146](https://store.rakwireless.com/products/wislink-concentrator-module-sx1303-rak5146-lorawan)

I'm not using it with Raspberry Pi, but the official example
[rak_common_for_gateway ](https://github.com/RAKWireless/rak_common_for_gateway)
gives a good idea of how to use it.

- `rak5146` is the same content with `rak_common_for_gateway/lora/rak5146`. Didn't touch much
- `sx1302_hal` contains `libloragw` and `packet_forwarder` with RAK5146 specific changes copied.

I wrote some `CMakelists.txt` to build the project since I can't read `Makefile`.

## Usage

```bash
cd sx1302_hal/libloragw
mkdir build
cd build
cmake ..
make -j$(nproc)
make install
```

```bash
cd sx1302_hal/packet_forwarder
mkdir build
cd build
cmake ..
make -j$(nproc)
cp ../../rak5146/global_conf_usb/global_conf.cn_470_510.json .
mv global_conf.cn_470_510.json global_conf.json
cp global_conf.json local_conf.json # no idea why both config files are needed
./packet_forwarder
```

- [Listen Before Talk – The Key to Good LoRaWAN® Communication](https://news.rakwireless.com/listen-before-talk-the-key-to-good-lorawan-r-communication/)
- [Semtech UDP packet-forwarder](https://www.chirpstack.io/gateway-bridge/backends/semtech-udp/)

![Packet Forwarder](figure/pkt_frd.png)
