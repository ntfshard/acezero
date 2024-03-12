extends Sprite2D

var startMenuObj = preload("res://desktop/startMenu.tscn").instantiate()

func _ready():
	startMenuObj.set_visible(false)
	$BottomMenu.add_child(startMenuObj)
	_on_second_timer_timeout()
	if Global.LoadToDesktop != null:
		get_tree().root.add_child(Global.LoadToDesktop.instantiate())
		Global.LoadToDesktop = null

func _on_second_timer_timeout():
	var time = Time.get_time_dict_from_system()
	$BottomMenu/TimeLabel.text = "%02d:%02d:%02d" % [time.hour, time.minute, time.second]

func _on_start_button_pressed():
	startMenuObj.set_visible(!startMenuObj.is_visible())

func _on_gameexe_pressed():
	get_tree().change_scene_to_file("res://gameexe/app.tscn")

