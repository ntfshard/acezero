extends ColorRect

var replyScene = preload("res://email/reply.tscn")

func _on_button_pressed():
	$Timer.start()

func _on_timer_timeout():
	add_child(replyScene.instantiate())
