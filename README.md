# MoralDNS
MoralDNS is a Raspberry Pi + masqdns based DNS/DHCP server which filters many ad serving + immoral domains, but you can also use in on a single workstation. It works by updating the host file with a long list of unwanted/bad domains and redirecting them to the IP address 0.0.0.0. This also saves bandwith. It is recommended to set this up on a Raspberry Pi (or similar) and redirect all DNS traffic to that.

To use it on a single workstation;

    sudo apt-get install git      # or: sudo yum install git
    cd ~
    git clone https://github.com/RoelVdP/MoralDNS.git
    cd MoralDNS
    ./getfilters.sh              # wait for downloads to finish
    <Warning: your hostfile will be overwritten with new version>
    <3x enter to confirm>

To use it on a Raspberry Pi with masqdns based DNS/DHCP; just setup masqdns then do the above single workstation steps on the Raspberry Pi. This should (in a normal setup) cause masqdns to use the updated host file.

MoralDNS currently blocks 115.000+ unique hosts
