#!/bin/bash
# Various lists https://filterlists.com/ - below is an optimized list of lists

add(){
  echo "Adding $(wc -l tmp) hosts to the temporary hosts file..."
  echo "-------"
  cat tmp | sed 's|[^- 0-9a-zA-Z\.]||g' | sed 's|#.*$||' | sed 's|[ \t]\+$||' >> hosts.tmp
  rm -f tmp
}

# Init 
rm -f a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac ad ae af ag ah ai aj tmp hosts.tmp hosts.tmpb
echo "*******************************************************************************************************************************************************************"
echo "*** Warning: this script will automatically overwrite /etc/hosts using sudo. If you do not want this, press CTRL+C on your keyboard now. Sleeping 30 seconds... ***"
echo "*******************************************************************************************************************************************************************"
sleep 30

# Original list of blocking domains and applicable license thereunto (compatible with GPLv2)
# Note; I do not endorse pi-hole in any way, and would strongly advice against it's use for several reasons
# including the possibility of security issues (malicious code insert/changing DNS entries to malicious ones)
# https://github.com/pi-hole/pi-hole/blob/master/adlists.default
# https://github.com/pi-hole/pi-hole/blob/master/LICENSE

# With thanks, StevenBlack list, this list combines several lists, ref https://github.com/StevenBlack/hosts for details
wget -Oa https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
grep "^0.0.0.0[ \t]" a | sort -u > tmp
add

# With thanks, MalwareDomains list
wget -Ob https://mirror1.malwaredomains.com/files/justdomains
grep -vE "^#|^$" b | sed "s|^|0.0.0.0 |" > tmp
add

# With thanks, Cameleon list
wget -Oc http://sysctl.org/cameleon/hosts
grep "^127.0.0.1" c | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add

# With thanks, Zeustracker list (blocks ZeuS hosts)
wget -Od https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
grep -vE "^#|^$" d | sed "s|^|0.0.0.0 |" > tmp
add

# With thanks, Disconnect.me Tracking list
wget -Oe https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
grep -vE "^#|^$" e | sed "s|^|0.0.0.0 |" > tmp
add

# With thanks, disconnect.me Ads list
wget -Of https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
grep -vE "^#|^$" f | sed "s|^|0.0.0.0 |" > tmp
add

# With thanks, Hosts-file.net list
wget -Og https://hosts-file.net/ad_servers.txt
grep "^127.0.0.1" g | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add

# Adult, gambling, and gaming sites list, with thanks http://www.hostsfile.org/hosts.html
wget -Oh.zip http://www.hostsfile.org/Downloads/BadHosts.msw.zip  
unzip h.zip
grep "^127.0.0.1" BadHosts.msw/hosts | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
rm -Rf BadHosts.msw h.zip
add

# Daily updated superlist, with thanks, https://github.com/notracking/hosts-blocklists/
wget -Oi https://raw.githubusercontent.com/notracking/hosts-blocklists/master/hostnames.txt
grep "^0.0.0.0[ \t]" i | sort -u > tmp
add
wget -Oj https://raw.githubusercontent.com/notracking/hosts-blocklists/master/domains.txt
grep "^address=/" j | sed 's|address=/|0.0.0.0 |;s|/.*||' | sort -u > tmp
add

# With thanks, https://someonewhocares.org/hosts/zero/
wget -Ok https://someonewhocares.org/hosts/zero/
grep "^0.0.0.0" k | sort -u > tmp
add

# With thanks, https://github.com/jerryn70/GoodbyeAds
wget -Ol https://raw.githubusercontent.com/jerryn70/GoodbyeAds/master/Hosts/GoodbyeAds.txt
grep "^0.0.0.0" l | sort -u > tmp
add

# With thanks, https://blog.cryptoaustralia.org.au/favourite-block-lists-cryptoaustralia/ and all linked domains below
wget -Om "https://hosts-file.net/exp.txt"
grep "^127.0.0.1" m | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add
wget -On "https://hosts-file.net/emd.txt"
grep "^127.0.0.1" n | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add
wget -Oo "https://hosts-file.net/psh.txt"
grep "^127.0.0.1" o | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add
wget -Op "https://www.malwaredomainlist.com/hostslist/hosts.txt"
grep "^127.0.0.1" p | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add
wget -Oq "https://hosts-file.net/ad_servers.txt"
grep "^127.0.0.1" q | sed 's|[ \t]\+| |g;s|127.0.0.1|0.0.0.0|' > tmp
add
wget -Or "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
grep "^0.0.0.0[ \t]" r | sort -u > tmp
add
wget -Os "https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt"
grep -vE "^#|^$" s | sed "s|^|0.0.0.0 |" > tmp
add
wget -Ot "https://ransomwaretracker.abuse.ch/downloads/LY_C2_DOMBL.txt"
grep -vE "^#|^$" t | sed "s|^|0.0.0.0 |" > tmp
add
wget -Ou "https://ransomwaretracker.abuse.ch/downloads/CW_C2_DOMBL.txt"
grep -vE "^#|^$" u | sed "s|^|0.0.0.0 |" > tmp
add
wget -Ov "https://ransomwaretracker.abuse.ch/downloads/TC_C2_DOMBL.txt"
grep -vE "^#|^$" v | sed "s|^|0.0.0.0 |" > tmp
add
wget -Ow "https://ransomwaretracker.abuse.ch/downloads/TL_C2_DOMBL.txt"
grep -vE "^#|^$" w | sed "s|^|0.0.0.0 |" > tmp
add
wget -Ox "https://v.firebog.net/hosts/AdguardDNS.txt"
grep -vE "^#|^$" x | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oy "https://isc.sans.edu/feeds/suspiciousdomains_Medium.txt"
grep -vE "^#|^$" y | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oz "https://v.firebog.net/hosts/Shalla-mal.txt"
grep -vE "^#|^$" z | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oaa "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
grep -vE "^#|^$" aa | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oab "http://www.joewein.net/dl/bl/dom-bl.txt"
grep -vE "^#|^$" ab | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oac "https://v.firebog.net/hosts/Easylist.txt"
grep -vE "^#|^$" ac | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oad "https://gist.githubusercontent.com/anudeepND/adac7982307fec6ee23605e281a57f1a/raw/5b8582b906a9497624c3f3187a49ebc23a9cf2fb/Test.txt"
grep -vE "^#|^$" ad | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oae "https://v.firebog.net/hosts/static/SamsungSmart.txt"
grep -vE "^#|^$" ae | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oaf "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt"
grep -vE "^#|^$" af | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oag "https://v.firebog.net/hosts/Easyprivacy.txt"
grep -vE "^#|^$" ag | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oah "https://v.firebog.net/hosts/Airelle-hrsk.txt"
grep -vE "^#|^$" ah | sed "s|^|0.0.0.0 |" > tmp
add
wget -Oai "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
grep -vE "^#|^$" ai | sed "s|^|0.0.0.0 |" > tmp
add

# Final cleanup (With thanks for CTRL+M example from; http://www.theunixschool.com/2011/03/different-ways-to-delete-m-character-in.html)
echo "Processing final merge and cleanup - this may take some time..."
echo "127.0.0.1 localhost dns" > hosts.tmpb
echo "::1 localhost ip6-localhost ip6-loopback" >> hosts.tmpb
echo "ff02::1 ip6-allnodes"   >> hosts.tmpb
echo "ff02::2 ip6-allrouters" >> hosts.tmpb
grep -vE "^0\.0\.0\.0$|^0\.0\.0\.0.*0\.0\.0\.0$|^[^0]|^0[^\.]|127\.0\.0\.1|localhost|ip6-loopback|ip6-allnodes|ip6-allrouters|::|goo\.gl$|googleadservices\.com$|amazon-adsystem\.com$|trackcmp\.net$|ad\.atdmt\.com$|alicdn\.com$|\.cfjump\.com$|r20\.rs6\.net$|app\.getresponse\.com$" hosts.tmp | sort -u >> hosts.tmpb

# Automatic writeout (allows cron automation)
echo "********************************************************************************************************************************************************************************************************"
echo "*** Overwriting /etc/hosts with the newly created host file containing ~$(wc -l hosts.tmpb | sed 's|[^0-9]||g') filter hosts. Press CTRL+C if you do not want this to happen. Sleeping 30 seconds... ***"
echo "********************************************************************************************************************************************************************************************************"
sleep 30
sudo cp hosts.tmpb /etc/hosts
rm -f a b c d e f g h i j k l m n o p q r s t u v w x y z aa ab ac ad ae af ag ah ai aj tmp hosts.tmp hosts.tmpb
