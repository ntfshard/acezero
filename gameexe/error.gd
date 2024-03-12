extends Node2D

func _ready():
	$Timer.start()

func _on_ok_button_pressed():
	get_tree().change_scene_to_file("res://desktop/app.tscn")

func _on_timer_timeout():
	$ErrorMsg.set_visible(true)
