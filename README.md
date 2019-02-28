# MoralDNS
MoralDNS is a DNS/DHCP server (based on masqdns, when used as intended) which filters many ad serving + immoral domains. You can use it standalone/directly on a single workstation (host file update only, no masqdns used) or set it up on Raspberry Pi (or similar) with masqdns and then redirect all DNS traffic on your network to it. In general, it works by updating the host file with a long list of unwanted/bad domains, and redirecting them to the IP address 0.0.0.0. This also saves bandwith (as webpages with ads on them will load and show without the ads).

To use it on a single workstation;

    sudo apt-get install git      # or: sudo yum install git
    cd ~
    git clone https://github.com/RoelVdP/MoralDNS.git
    cd MoralDNS
    ./getfilters.sh              # wait for downloads to finish
    <Warning: your hostfile will be overwritten with new version>
    <3x enter to confirm>

To use it on a Raspberry Pi (or similar) with masqdns based DNS/DHCP; just setup masqdns (https://wiki.debian.org/HowTo/dnsmasq) then do the above single workstation steps on the Raspberry Pi. This should (in a normal setup) cause masqdns to use the updated host file. Then point your workstations to the Raspberry Pi for DNS resolution. If you setup a DHCP on the Raspberry Pi as well, then do not forget to disable DHCP on your normal router - two DHCP servers on the same network is bound to cause IP address conflicts.

In summary, you can use this script to simply generate a hosts file, and overwrite your current host file (note the overwrite warning). Or, take it one step further and install the (seperate/not incuded) masqdns for central DNS resolution or for central DNS+DHCP resolution+server.

Note that running the getfilters.sh script (Linux based) on Windows may not be straightforward. If you use Windows a lot, the Raspberry Pi (running Raspbian for example) running DNS or DNS+DHCP would be a great way to setup your environment. A Raspberry Pi 2 is quite sufficient for a small to medium network size.

Once in a while, re-run ./getfilters.sh to update your filter list (i.e. host file) to the latest one. Often a few thousand hosts will have been added to the lists MoralDNS obtains from various providers, or at times one of the providers will cleanup their list (or similar), and there will be a reduction in hosts filtered. To see approximately how many hosts are blocked, execute:  wc -l /etc/hosts

Enjoy an almost completely ad and immoral-websites free browsing experience! Great for families! You'll also find that various trackers, like for example clicktale.com, are blocked too!

MoralDNS currently blocks 120.000+ unique hosts. Enjoy!
