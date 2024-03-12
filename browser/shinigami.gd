extends ColorRect

func _on_close_button_pressed():
	queue_free()

func _on_login_line_edit_text_submitted(_new_text):
	checkAndEnding()

func _on_pass_line_edit_text_submitted(_new_text):
	checkAndEnding()

func checkAndEnding():
	if $Shinigami/LoginLineEdit.text == 'ntfshard' && $Shinigami/PassLineEdit.text == 'D00m3D:':
		Global.RunEnding(Global.Endings.Deep)
	else:
		$Shinigami/PassLineEdit.text = ''
