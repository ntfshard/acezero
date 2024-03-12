extends ColorRect

var sendScene = preload("res://email/send.tscn")

func _ready():
	if Global.SendMail:
		add_child(sendScene.instantiate())

func _on_exit_button_pressed():
	self.queue_free()
