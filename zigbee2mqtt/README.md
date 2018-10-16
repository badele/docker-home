Make cc-tool binarie 
--------------------

git clone https://github.com/dashesy/cc-tool.git
cd cc-tool
yaourt -Ss libusb boost
./configure
make

get CC2531ZNP-prod.hex
----------------------
wget https://raw.githubusercontent.com/Koenkk/Z-Stack-firmware/master/coordinator/CC2531/bin/CC2531ZNP-Prod.hex

Flash firmware
--------------
sudo cc-tool/cc-tool -e -w CC2531ZNP-Prod.hex

run zigbee2mqtt stack
-------------------------
docker run -ti -p 1883:1883 -p 9001:9001 toke/mosquitto

git@github.com:Koenkk/zigbee2mqtt.git
cd zigbee2mqtt
docker run \
   -it \
   -v $(pwd)/data:/app/data \
   --device=/dev/ttyACM0 \
   koenkk/zigbee2mqtt

docker run -it --rm efrecon/mqtt-client sub -h 192.168.254.22 -t "#" -v
