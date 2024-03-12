extends ColorRect

func _on_mine_sweeper_button_pressed():
	var app = preload("res://minesweeper/app.tscn").instantiate()
	get_tree().root.add_child(app)
	self.set_visible(false)

func _on_dbgai_button_pressed():
	var app = preload("res://dbgai/app.tscn").instantiate()
	get_tree().root.add_child(app)
	self.set_visible(false)

func _on_browser_button_pressed():
	var app = preload("res://browser/app.tscn").instantiate()
	get_tree().root.add_child(app)
	self.set_visible(false)

func _on_email_button_pressed():
	var app = preload("res://email/app.tscn").instantiate()
	get_tree().root.add_child(app)
	self.set_visible(false)
