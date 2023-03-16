#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo "SCRIPT_DIR=$SCRIPT_DIR"
HAL_PATH="$SCRIPT_DIR/../sx1302_hal"
LIBLORAGW_PATH="$HAL_PATH/libloragw"
cp ./loragw_stts751.c $LIBLORAGW_PATH/src/ -f
cp ./loragw_gps.c $LIBLORAGW_PATH/src/ -f
cp ./loragw_hal.c $LIBLORAGW_PATH/src/ -f
cp ./test_loragw_gps_uart.c $LIBLORAGW_PATH/tst/test_loragw_gps.c -f
cp ./test_loragw_gps_i2c.c $LIBLORAGW_PATH/tst/ -f
cp ./test_loragw_hal_tx.c $LIBLORAGW_PATH/tst/ -f
cp ./Makefile $LIBLORAGW_PATH/ -f

cp ./lora_pkt_fwd.c $HAL_PATH/packet_forwarder/src/
