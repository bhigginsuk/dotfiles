//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "cmus-remote -Q | sed -n 's/tag artist //p; s/tag title //p; s/tag album //p' | tac | tr '\n' '#' | sed 's/.$/\n/g; s/#/ - /g'",	30,		0},

    {"", "/home/b/bin/dwm-scripts/github-notifications", 3600, 0},

    {"", "/usr/bin/mailcheck -bc | sed -z 's/\n/+/; s/[^0-9+\n]//g' | bc | awk -v def=\"0\" '{print $1} END {if(NR==0){print def}} END {print \" new email(s)\"}' | tr -d '\n' && systemctl --user status mbsync.service |  awk '/Active:/ { match($0, /[0-9]min/,arr); if(arr[0]) {printf \" (\"arr[0]} else {printf \" (<1min\"}} END {print \" ago)\"}'", 60, 0},

    {"", "checkupdates | wc -l | awk '{ if ($1) print \"Pacman: \"$1 }'", 3600, 0},

    {"", "yay -Qua | wc -l | awk '{ if ($1) print \"Yay: \"$1 }'", 3600, 0},

    {"", "curl -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=USD' -H 'accept: application/json' | jq '.bitcoin.usd'", 900, 0},
    
    {"", "curl -X GET 'https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=USD' -H 'accept: application/json' | jq '.ethereum.usd'", 900, 0},

    {"", "curl -Ss 'wttr.in/London?format=%C+%t/%f+%S-%s\n'", 3600, 0},

    {"", "/usr/bin/protonvpn status | grep Status: | sed -E 's/ +/ /'", 30, 0},

    {"", "/usr/bin/protonvpn status | grep Server: | sed -E 's/ +/ /'", 30, 0},

    {"", "/usr/bin/protonvpn status | grep IP: | sed -E 's/ +/ /'", 30, 0},

    {"LOAD", "/home/b/bin/dwm-scripts/load_average", 10, 0},

    {"CPU", "/home/b/bin/dwm-scripts/cpu_usage", 10, 0},

    {"TEMP", "/home/b/bin/dwm-scripts/temperature", 10, 0},

    {"MEM", "/home/b/bin/dwm-scripts/memory", 30, 0},

    {"", "/home/b/bin/dwm-scripts/iface eno1", 60, 0},

    {"", "date '+%g %V %u %H' | awk '{ w = $1$2; print(\"W\"w-2038\"/\"(($3 > 2 && $4 > 11) || ($3 > 3) ? w : w-1)); }'", 5, 0},

    {"", "date '+%A %Y-%m-%d %H:%M %Z'", 5, 0}
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;