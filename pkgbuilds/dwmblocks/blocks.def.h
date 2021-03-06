//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
    {"", "checkupdates | wc -l | awk '{ print \"P: \"($1 > 0 ? $1 : \"✓\") }'", 3600, 0},

    {"", "yay -Qua | wc -l | awk '{ print \"Y: \"($1 > 0 ? $1 : \"✓\") }'", 3600, 0},

    {"", "curl 'https://query1.finance.yahoo.com/v7/finance/quote?lang=en-US&region=US&corsDomain=finance.yahoo.com&symbols=GME' | jq .quoteResponse.result[0].ask | awk '{ printf(\"GME: %.2f\", $1) }'", 900, 0},

    {"", "curl -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=USD' -H 'accept: application/json' | jq '.bitcoin.usd' | awk '{ printf(\"BTC: %.2f\", $1) }'", 900, 0},
    
    {"", "curl -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=USD' -H 'accept: application/json' | jq '.ethereum.usd' | awk '{ printf(\"ETH: %.2f\", $1) }'", 900, 0},

    {"", "curl -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=maker&vs_currencies=USD' -H 'accept: application/json' | jq '.maker.usd' | awk '{ printf(\"MKR: %.2f\", $1) }'", 900, 0},

    {"", "curl -X GET 'https://ethgasstation.info/api/ethgasAPI.json' | jq '.safeLow' | awk '{ printf(\"Gas: %03d\", $0/10) }'", 900, 0},

    {"", "/usr/bin/protonvpn status | grep Server: | sed -E 's/Server: +//'", 30, 0},

    {"", "/usr/bin/protonvpn status | grep IP: | sed -E 's/IP: +//'", 30, 0},

    {"", "/usr/bin/cut -d ' ' -f1 /proc/loadavg | awk '{ printf(\"%05.2f\", $0) }'", 10, 0},

    {"", "top -b -n 1 | grep ^%Cpu | awk '{printf(\"%05.2f%\", 100-$8) }'", 10, 0},

    {"", "/home/b/bin/dwm-scripts/temperature", 10, 0},

    {"", "/home/b/bin/dwm-scripts/memory", 30, 0},

    {"", "systemctl --user show -p ActiveState --value syncthing | awk '{ print(\"S: \"(($1 == \"active\") ? \"✓\" : \"✗\")) }'", 60, 0},

    {"", "systemctl --user show -p ActiveState --value ipfs | awk '{ print(\"I: \"(($1 == \"active\") ? \"✓\" : \"✗\")) }'", 60, 0},

    {"", "systemctl --user show -p Result --value mbsync.timer | awk '{ print(\"M: \"(($1 == \"success\") ? \"✓\" : \"✗\")) }'", 60, 0},

    {"", "date '+%g %V %u %H' | awk '{ w = $1$2; print(\"W\"w-2103\"/\"(($3 > 2 && $4 > 11) || ($3 > 3) ? w : w-1)); }'", 5, 0},

    {"", "date '+%a %Y-%m-%d %H:%M %Z'", 5, 0},

    {"", "/home/b/bin/dwm-scripts/battery | sed -n 2p", 60, 0 }
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
