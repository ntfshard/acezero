extends ColorRect

func _ready():
	if Global.Ending == Global.Endings.Ask:
		$AColorRect.set_visible(false)
	elif Global.Ending == Global.Endings.BadAss:
		$BColorRect.set_visible(false)
	elif Global.Ending == Global.Endings.CanPlay:
		$CColorRect.set_visible(false)
	elif Global.Ending == Global.Endings.Deep:
		$DColorRect.set_visible(false)
	else:
		$EndingLabel.text = $EndingLabel.text + " Unknown!\nBug detected"

func _on_link_button_pressed():
	Global.Ending = Global.Endings.Unknown
	get_tree().change_scene_to_file("res://desktop/app.tscn")
