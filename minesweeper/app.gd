extends ColorRect

var fieldSize = 9

var plainTexture = load("res://minesweeper/plain.png")
var flagTexture = load("res://minesweeper/flag.png")
var mineTexture = load("res://minesweeper/mine.png")
var mineRedTexture = load("res://minesweeper/mine_red.png")
var nums = [
	 load("res://minesweeper/open.png"),
	 load("res://minesweeper/1.png"),
	 load("res://minesweeper/2.png"),
	 load("res://minesweeper/3.png"),
	 load("res://minesweeper/4.png"),
	 load("res://minesweeper/5.png"),
	 load("res://minesweeper/6.png"),
	 load("res://minesweeper/7.png"),
	 load("res://minesweeper/8.png")
]

var CellKey = "Cell"
var HasMineKey = "HasMine"
enum Cell {Hidden, Open, Locked}

var endingCounter = 0
const gamesTillEndScreen = 5

# game state:
var mines = 10
var seconds = 0
var errors = 0	# used for a fast win condition detect
var fail = false
var field = Array()

func endScreenCheck():
	Global.MinesweeperGameEnd()
	# can use signals but here it's only one place, let it be direct call

func reset():
	$VBoxContainer/TopHBoxContainer/OneSecondTimer.stop()
	for i in fieldSize:
		for j in fieldSize:
			field[i][j].set_meta(CellKey, Cell.Hidden)
			field[i][j].set_meta(HasMineKey, false)
			field[i][j].texture_normal = plainTexture
	seconds = 0
	errors = 0
	fail = false
	$VBoxContainer/TopHBoxContainer/TimeLabel.text = str(seconds)
	populateMines()

func populateMines():
	var rng = RandomNumberGenerator.new()
	var have_mines = 0
	mines = 10
	while have_mines < mines:
		var x = rng.randi_range(0, fieldSize-1)
		var y = rng.randi_range(0, fieldSize-1)
		if !field[x][y].get_meta(HasMineKey):
			have_mines += 1
			field[x][y].set_meta(HasMineKey, true)
	$VBoxContainer/TopHBoxContainer/CounterLabel.text = str(mines)

func countMinesAround(x, y):
	var result = 0
	for i in range(x-1, x+2):
		for j in range(y-1, y+2):
			if i < 0 || i >= field.size() || j < 0 || j >= field[i].size():
				continue
			if field[i][j].get_meta(HasMineKey):
				result += 1
	return result

# fake callstack, can use recursion here C:
func startRevealingWave(x, y):
	assert(!field[x][y].get_meta(HasMineKey))
	var minesAround = countMinesAround(x, y)
	field[x][y].texture_normal = nums[minesAround]
	field[x][y].set_meta(CellKey, Cell.Open)
	if 0 == minesAround:
		for i in range(x-1, x+2):
			for j in range(y-1, y+2):
				if i < 0 || i >= field.size() || j < 0 || j >= field[i].size():
					continue
				if field[i][j].get_meta(CellKey) == Cell.Hidden && ! field[i][j].get_meta(HasMineKey):
					startRevealingWave(i, j)

func gameOver(x, y):
	fail = true
	$VBoxContainer/TopHBoxContainer/OneSecondTimer.stop()
	endScreenCheck()
	for i in fieldSize:
		for j in fieldSize:
			if field[i][j].get_meta(HasMineKey) && field[x][y].get_meta(CellKey) == Cell.Hidden:
				field[i][j].texture_normal = mineTexture
	field[x][y].texture_normal = mineRedTexture

func _ready():
	$VBoxContainer/Field.set_columns(fieldSize)
	for i in fieldSize:
		field.push_back(Array())
		for j in fieldSize:
			var b = TextureButton.new()
			b.set_meta(CellKey, Cell.Hidden)
			b.set_meta(HasMineKey, false)
			b.texture_normal = plainTexture
			b.gui_input.connect(_button_input.bind(i, j))
			field[i].push_back(b)
			$VBoxContainer/Field.add_child(b)
	populateMines()

func _button_input(event, x, y):
	if event is InputEventMouseButton:
		if $VBoxContainer/TopHBoxContainer/OneSecondTimer.is_stopped():
			if fail == false:
				$VBoxContainer/TopHBoxContainer/OneSecondTimer.start()
			else:
				return
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			if field[x][y].get_meta(CellKey) == Cell.Locked || field[x][y].get_meta(CellKey) == Cell.Open:
				pass
			elif field[x][y].get_meta(HasMineKey):
				gameOver(x, y)
			elif field[x][y].get_meta(CellKey) == Cell.Hidden:
				startRevealingWave(x, y)
		if event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
			if field[x][y].get_meta(CellKey) == Cell.Hidden:
				field[x][y].texture_normal = flagTexture
				field[x][y].set_meta(CellKey, Cell.Locked)
				if !field[x][y].get_meta(HasMineKey):
					errors += 1
				mines -= 1
			elif field[x][y].get_meta(CellKey) == Cell.Locked:
				field[x][y].texture_normal = plainTexture
				field[x][y].set_meta(CellKey, Cell.Hidden)
				if !field[x][y].get_meta(HasMineKey):
					errors -= 1
				mines += 1
			$VBoxContainer/TopHBoxContainer/CounterLabel.text = str(mines)
			if mines == 0 && errors == 0:
				$VBoxContainer/TopHBoxContainer/OneSecondTimer.stop()
				endScreenCheck()

func _on_one_second_timer_timeout():
	seconds += 1
	$VBoxContainer/TopHBoxContainer/TimeLabel.text = str(seconds)

func _on_reset_button_pressed():
	reset()

func _on_exit_button_pressed():
	self.queue_free()
