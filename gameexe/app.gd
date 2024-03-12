extends Node2D

var errorNode = preload("res://gameexe/error.tscn")
var aboutNode = preload("res://gameexe/about.tscn")

func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://desktop/app.tscn")

func _on_new_button_pressed():
	newGameCrashSeq()

func _on_about_button_pressed():
	add_child(aboutNode.instantiate())

func newGameCrashSeq():
	Global.CrashSeen = true
	add_child(errorNode.instantiate())
