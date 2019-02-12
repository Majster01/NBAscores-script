#!/usr/bin/python3

import json
import string

scripts = "/home/majst3r/.scripts/NBAscores/"
gamesFile = "nba_games_today.txt"
gamesOutFile = "games.txt"
teamsFile = "teams_dict.txt"
gameIdsOutFile = "games_ids.txt"

def filterName(nickname):
	name = nickname
	tmp = nickname.split()
	if len(nickname.split()) > 1:
		name = tmp[1]

	return name

if __name__ == '__main__':

	json_decoder = json.JSONDecoder()
		
	gamesString = open(scripts + gamesFile).readline()
	teamsString = open(scripts + teamsFile).readline()

	gamesOut = open(scripts + gamesOutFile, "w")
	gamesIdsOut = open(scripts + gameIdsOutFile, "w")

	#print(gamesString)
	games = json_decoder.decode(gamesString)["api"]["games"]
	teams = json_decoder.decode(teamsString)

	games_print = {}
	games_ids = []

	for i, game in enumerate(games):

		teamVname = filterName(teams[game["vTeam"]["teamId"]])
		teamHname = filterName(teams[game["hTeam"]["teamId"]])

		games_ids.append(game["gameId"])

		if game["statusShortGame"] == "3": #finished
			teamVscore = game["vTeam"]["score"]["points"]
			teamHscore = game["hTeam"]["score"]["points"]
			games_print[game["gameId"]] = ("%s %s (%d) %s %s" % (teamVname, teamVscore, (i+1), teamHscore, teamHname))
		elif game["statusShortGame"] == "2": #live
			teamVscore = game["vTeam"]["score"]["points"]
			teamHscore = game["hTeam"]["score"]["points"]
			games_print[game["gameId"]] = ("%s %s (↑) %s %s" % (teamVname, teamVscore, teamHscore, teamHname))
		elif game["statusShortGame"] == "1": #scheduled
			teamVscore = "/"
			teamHscore = "/"
			games_print[game["gameId"]] = ("%s %s (↓) %s %s" % (teamVname, teamVscore, teamHscore, teamHname))


	gamesIdsOut.write(json.dumps(games_ids))
	#print(json.dumps(games_ids))
	#print(json.dumps(games_print))

	gamesOut.write(json.dumps(games_print))

