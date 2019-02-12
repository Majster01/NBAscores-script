#!/usr/bin/python

import json


scripts = "/home/majst3r/.scripts/"
gameFile = "game_data.txt"
gameOutFile = "game.txt"

if __name__ == '__main__':

	json_decoder = json.JSONDecoder()
		
	gameString = open(scripts + gameFile).readline()

	gameOut = open(scripts + gameOutFile, "w")

	#print(gamesJSON)
	game = json_decoder.decode(gameString)["api"]["game"][0]

	print(game)

	hTeam = game["hTeam"]
	vTeam = game["vTeam"]

	data = {}

	info = []
	info.append("%s %s" % (hTeam["nickname"], vTeam["nickname"]))
	info.append("%s %s" % (hTeam["score"]["points"], vTeam["score"]["points"]))
	info.append("Players: Players:")

	players = []
	players.append("%s %s" % (hTeam["leaders"][0]["name"].replace(" ", "_"), vTeam["leaders"][0]["name"].replace(" ", "_")))
	players.append("P:%s P:%s" % (hTeam["leaders"][0]["points"], vTeam["leaders"][0]["points"]))
	players.append("%s %s" % (hTeam["leaders"][1]["name"].replace(" ", "_"), vTeam["leaders"][1]["name"].replace(" ", "_")))
	players.append("R:%s R:%s" % (hTeam["leaders"][1]["rebounds"], vTeam["leaders"][1]["rebounds"]))
	players.append("%s %s" % (hTeam["leaders"][2]["name"].replace(" ", "_"), vTeam["leaders"][2]["name"].replace(" ", "_")))
	players.append("A:%s A:%s" % (hTeam["leaders"][2]["assists"], vTeam["leaders"][2]["assists"]))

	data["info"] = info
	data["players"] = players

	gameOut.write(json.dumps(data))