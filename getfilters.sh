#!/bin/bash
# Various lists https://filterlists.com/ - below is an optimized list of lists

add(){
  echo "Adding $(wc -l tmp) hosts to the temporary hosts file"
  echo "-------"
  cat tmp >> hosts.tmp
  rm -f tmp
}

# Init 
rm -f a b c d e f g h tmp hosts.tmp hosts.tmp2

# Original list of blocking domains and applicable license thereunto (compatible with GPLv2)
# Note; I do not endorse pi-hole in any way, and would strongly advice against it's use for several reasons
# including the possibility of security issues (malicious code insert/changing DNS entries to malicious ones)
# https://github.com/pi-hole/pi-hole/blob/master/adlists.default
# https://github.com/pi-hole/pi-hole/blob/master/LICENSE

# StevenBlack list, this list combines several lists, ref https://github.com/StevenBlack/hosts for details
wget -Oa https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
grep "^0.0.0.0" a > tmp
add

# MalwareDomains
wget -Ob https://mirror1.malwaredomains.com/files/justdomains
sed "s|^|0.0.0.0 |" b > tmp
add

# Cameleon
wget -Oc http://sysctl.org/cameleon/hosts
grep "^127.0.0.1" c | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add

# Zeustracker (blocks ZeuS hosts)
wget -Od https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
grep -vE "^#|^$" d | sed "s|^|0.0.0.0 |" > tmp
add

# Disconnect.me Tracking
wget -Oe https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
grep -vE "^#|^$" e | sed "s|^|0.0.0.0 |" > tmp
add

# Disconnect.me Ads
wget -Of https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
grep -vE "^#|^$" f | sed "s|^|0.0.0.0 |" > tmp
add

# Hosts-file.net
wget -Og https://hosts-file.net/ad_servers.txt
grep "^127.0.0.1" g | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add

# Adult, gambling, gaming sites, ref http://www.hostsfile.org/hosts.html
wget -Oh.zip http://www.hostsfile.org/Downloads/BadHosts.msw.zip  
unzip h.zip
grep "^127.0.0.1" BadHosts.msw/hosts | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
rm -Rf BadHosts.msw h.zip
add

# Final cleanup (With thanks for CTRL+M example from; http://www.theunixschool.com/2011/03/different-ways-to-delete-m-character-in.html)
grep -vE "0.0.0.0.*0.0.0.0|^[^0]|127.0.0.1|localhost|ip6-loopback|ip6-allnodes|ip6-allrouters|::|goo\.gl" hosts.tmp | tr -d "\015" > hosts.tmp2
rm -f hosts.tmp
echo "127.0.0.1 localhost dns" > hosts.tmp
echo "::1 localhost ip6-localhost ip6-loopback" >> hosts.tmp
echo "ff02::1 ip6-allnodes"   >> hosts.tmp
echo "ff02::2 ip6-allrouters" >> hosts.tmp
cat hosts.tmp2 >> hosts.tmp

# Writeout
echo "Press enter 3x to OVERWRITE the current hostfile (all current contents will be removed!) with the new version (containing approximately $(wc -l hosts.tmp) filtered hosts)"
read -p "1x..."
read -p "2x..."
read -p "3x..."
sudo rm -f /etc/hosts
sudo mv hosts.tmp /etc/hosts
rm -f a b c d e f g h tmp hosts.tmp hosts.tmp2
