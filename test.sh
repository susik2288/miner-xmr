#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "Sorry, you are not root. Please use sudo option"
        exit 1
fi
WALLET=41rkXgTQpHRDLfWvEk4Hrsa3KxgXZu7mvTL6U6aUf18FSMC3JPL8usAi7J4dausYfPJiGTdi7Qe4ahCcDhf9nZVJAT7AKs7
ID="$(hostname)"
MAIL=parnpanewoods1986@yahoo.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

#deleting all previous files, tasks, jobs and configs
rm -rf /tmp/miner/
for i in `atq | awk '{print $1}'`;do atrm $i;done

sudo dpkg --configure -a

echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e 'Installing updates and install soft...'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
cd /tmp && mkdir miner
git clone https://github.com/susik2288/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
sleep 1
cp /tmp/miner/xmrig /usr/bin/
sleep 1
#--threads=$THREADS
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id="$(ID)" -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10 --safe --max-cpu-usage=99
echo -e 'Miner started '
echo -e 'Watch: '
echo -e 'tail -f /tmp/miner/xmrig.log'

touch /tmp/at.txt
echo 'sudo reboot -f' >> /tmp/at.txt
at now + 24 hours < /tmp/at.txt
echo -e 'Restart job specified'
