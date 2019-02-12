#!/bin/bash

DATE=`date +%Y-%m-%d`

#PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

FILES_PATH="/home/majst3r/.scripts/NBAscores/"
GAMES_PATH="games.txt"
GAMES_RAW_PATH="nba_games_today.txt"
IDS_PATH="games_ids.txt"


function updateData {
	curl -s -H "X-RapidAPI-Key: 977a209e39msh8a118d8e2048707p1a636ejsna5db93357e85" -X GET https://api-nba-v1.p.rapidapi.com/games/date/$DATE > $FILES_PATH$GAMES_RAW_PATH
	wait ${!}
	nba_data
	GAMES=$(cat $FILES_PATH$GAMES_PATH)
	IDS_TMP=$(cat $FILES_PATH$IDS_PATH | jq .[])

	IDS=()
	for i in $IDS_TMP; do IDS+=($i); done
}

updateData

function formatGame {
	padlimit=25
	pad=$(printf '%*s' "$padlimit")
	pad=${pad// / }
	padlength=13
	printf " │\t"
	for i in $1
	do
		i=$(echo $i | tr '"' ' ')
	    printf '%s' "$i"
	    printf '%*.*s' 0 $((padlength - ${#i} )) "$pad"
	done
	printf '│\n'
}

function showGames {
	echo ""
    echo -e "                   ::NBA games from today:: $DATE"
    echo -e " ┌───────────────────────────────────────────────────────────────────────┐"
	#for i in $IDS; do echo -e " │    1    $(echo $GAMES | jq .$i)\t│"; done
	for i in "${IDS[@]}"; do formatGame "$(echo $GAMES | jq .$i)"; done
    echo -e " └───────────────────────────────────────────────────────────────────────┘"
    echo -e "              R Update list       -       Q   Exit "
    echo ""

}

function main {

	while true; do
		
		clear
		showGames

		read -s -n1 choix
		case $choix in
			1)
				echo $choix
				nba_game ${IDS[0]}
				echo ""
				;;
			2)
				echo $choix
				nba_game ${IDS[1]}
				echo ""
				;;
			3)
				echo $choix
				nba_game ${IDS[2]}
				echo ""
				;;
			4)
				echo $choix
				nba_game ${IDS[3]}
				echo ""
				;;
			5)
				echo $choix
				nba_game ${IDS[4]}
				echo ""
				;;
			6)
				echo $choix
				nba_game ${IDS[5]}
				echo ""
				;;
			7)
				echo $choix
				nba_game ${IDS[6]}
				echo ""
				;;
			8)
				echo $choix
				nba_game ${IDS[7]}
				echo ""
				;;
			9)
				echo $choix
				nba_game ${IDS[8]}
				echo ""
				;;
			0)
				echo $choix
				nba_game ${IDS[9]}
				echo ""
				;;
			r)
				echo "Getting data"
				updateData

				echo ""
				;;
			q)
				clear && exit
				;;
			*)
				echo -e "ERROR"
				read -s -n1
					clear
				;;
		esac
	done
}

main