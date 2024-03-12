extends Node

enum Endings {Unknown, Ask, BadAss, CanPlay, Deep}
var Ending = Endings.Unknown

func RunEnding(ending: Endings):
	Global.Ending = ending
	get_tree().change_scene_to_file("res://ending/ending.tscn")

var MineSwGamesPlayed = 0
const MineSwGamesEndingLimit = 5
func MinesweeperGameEnd():
	MineSwGamesPlayed += 1
	if MineSwGamesPlayed == MineSwGamesEndingLimit:
		RunEnding(Global.Endings.CanPlay)

var CrashSeen = false
var SendMail = false

# to run desktop with specific application
var LoadToDesktop = null

var DbgLastCode = []
var DbgCurrentProblemIdx = 0
