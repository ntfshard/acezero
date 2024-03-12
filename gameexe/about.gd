extends Node2D

var emailApp = preload("res://email/app.tscn")

func _on_exit_button_pressed():
	queue_free()

func _on_contact_us_button_pressed():
	if Global.CrashSeen:
		Global.SendMail = true
		Global.LoadToDesktop = emailApp
		get_tree().change_scene_to_file("res://desktop/app.tscn")
