#!/bin/bash
ID=$1
ID="${ID%\"}"
ID="${ID#\"}"

FILES_PATH="/home/majst3r/.scripts/"
GAME_RAW_PATH="game_data.txt"
GAME_PATH="game.txt"

function updateData {
	curl -s -H "X-RapidAPI-Key: 977a209e39msh8a118d8e2048707p1a636ejsna5db93357e85" -X GET https://api-nba-v1.p.rapidapi.com/gameDetails/$ID > $FILES_PATH$GAME_RAW_PATH
	nba_game_data
}

updateData

function formatInfo {
	padlimit=40
	pad=$(printf '%*s' "$padlimit")
	pad=${pad// / }
	padlength=25
	printf " │\t\t"
	for i in $1
	do
		i=$(echo $i | tr '"' ' ')
	    printf '%s' "$i"
	    printf '%*.*s' 0 $((padlength - ${#i} )) "$pad"
	done
	printf '  │\n'
}

function showGameInfo {
	echo ""
    echo -e "              ::NBA games: details: "
    echo -e " ┌──────────────────────────────────────────────────────────────────┐"
	#for i in $IDS; do echo -e " │    1    $(echo $GAMES | jq .$i)\t│"; done
	#for i in "${IDS[@]}"; do formatGame "$(echo $GAMES | jq .$i)"; done
	for i in {0..2}; do formatInfo "$(cat $FILES_PATH$GAME_PATH | jq .info[$i])"; done
}

function formatPlayers {
	padlimit=40
	pad=$(printf '%*s' "$padlimit")
	pad=${pad// / }
	padlength=25
	printf " │\t\t  "
	for i in $1
	do
		i=$(echo $i | tr '"' ' ')
	    printf '%s' "$i"
	    printf '%*.*s' 0 $((padlength - ${#i} )) "$pad"
	done
	printf '│\n'
}

function showGamePlayers {
	for i in {0..5}; do formatPlayers "$(cat $FILES_PATH$GAME_PATH | jq .players[$i])"; done
    echo -e " └──────────────────────────────────────────────────────────────────┘"
    echo -e "             9 Update list       -       0   Back "
    echo ""

}

function main {

	while true; do
		
		clear

		showGameInfo
		showGamePlayers

		read -s -n1 choix
		case $choix in
			1)
				echo $choix
				echo -e $ID
				read -s -n1
					clear
				;;
			9)
				echo "pridobivam podatke"
				updateData
				echo ""
				;;
			0)
				clear && exit
				;;
			*)
				echo -e "NAPAKA"
				read -s -n1
					clear
				;;
		esac
	done
}

main