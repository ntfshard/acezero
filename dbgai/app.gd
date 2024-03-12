extends ColorRect

# rude cpu interpreter implementation
enum Access {r, rw}
enum Type   {reg, mem}
enum ParceResult {Ok, Skip, Error}

#region AccessWrappers
# mov ax, 1337
class intAccessWrapper:
	var val: int
	func  _init(val_: int):
		val = val_
	func read() -> Array:
		return [true, val]
	func write(value):
		return [false, "Can't store value %d in integer %d, maybe you should use register or memory" % [value, val]]
	func dst() ->String:
		return "%d" % [val]

# mov ax, bx
class regAccessWrapper:
	var cpu: Cpu
	var reg: String
	func  _init(cpu_: Cpu, reg_: String):
		cpu = cpu_
		reg = reg_
		assert(cpu.regs.has(reg))
	func write(value) -> Array:
		cpu.regs[reg] = value
		return [true, null]
	func read() -> Array:
		return [true, cpu.regs[reg]]
	func dst() ->String:
		return reg

# inc [ax]
class memoryAccessIndirectOneArg:
	var cpu: Cpu
	var srcA
	func  _init(cpu_: Cpu, a):
		cpu = cpu_
		srcA = a
		assert(srcA is regAccessWrapper || srcA is intAccessWrapper)
	func write(value) -> Array:
		var addr = srcA.read().back()
		if !cpu.memoryAccess.has(addr) || cpu.memoryAccess[addr] != Access.rw:
			return [false, 'Attempt to write to a RO address %s: %x' % [srcA.dst(), addr]]
		# technically we could check existance of addr also here...
		cpu.memory[addr] = value
		return [true, '']
	func read() -> Array:
		var addr = srcA.read().back()
		if !cpu.memory.has(addr):
			return [false, 'Attempt to read uninitialized memory at %s: %x' % [srcA.dst(), addr] ]
		return [true, cpu.memory[addr]]
	func dst() ->String:
		return srcA

#inc [ax+bx]
class memoryAccessIndirectTwoArgs:
	var cpu: Cpu
	var srcA
	var srcB
	func  _init(cpu_: Cpu, a, b):
		cpu = cpu_
		srcA = a
		srcB = b
		assert(srcA is regAccessWrapper || srcA is intAccessWrapper)
		assert(srcB is regAccessWrapper || srcB is intAccessWrapper)
	func write(value) -> Array:
		var addr = srcA.read().back() + srcB.read().back()
		if !cpu.memoryAccess.has(addr) || cpu.memoryAccess[addr] != Access.rw:
			return [false, 'Attempt to write to a RO address %x by %s+%s' % [addr, srcA.dst(), srcB.dst()] ]
		cpu.memory[addr] = value
		return [true, '']
	func read() -> Array:
		var addr = srcA.read().back() + srcB.read().back()
		if !cpu.memory.has(addr):
			return [false, 'Attempt to read uninitialized memory at %s+%s: %x' % [srcA.dst(), srcB.dst(), addr] ]
		return [true, cpu.memory[addr]]
	func dst() ->String:
		return "%s+%s" % [srcA, srcB]
#endregion

const oneArgOpcodes = {'inc':true, 'dec':true, 'not':true}
const twoArgOpcodes = {'mov':true, 'add':true, 'sub':true,
			'xor':true, 'or':true, 'and':true, 'mul':true}

class Cpu:
	var regs = {'ax':42+1, 'bx':42+4, 'cx':42+6, 'dx':42+8}
	var memoryAccess = {}
	var memory = {}
	var next = 0
	var errorMsg = ''
	func addMemReg(from:int, length:int, mode:Access) :
		for i in range(from, from+length):
			memoryAccess[i] = mode
			memory[i] = 69
	func execute(prog: Array):
		next = 0
		while next < prog.size():
			#print(regs, memory)
			runOp(prog[next])
			print(regs, memory)
	func halt(error:String):
		next = 2**30
		errorMsg = error
		#print(errorMsg)
	func runOp(op:Array):
		var opA
		var opB
		if oneArgOpcodes.has(op.front()):
			# only 1 argument, we will read and write it
			assert(op.size() == 2)
			var resA = op[1].read()
			if !resA.front():
				halt(resA.back())
				return
			opA = resA.back()
		elif twoArgOpcodes.has(op.front()):
			# here we can only guarantee read access to the last argument
			assert(op.size() == 3)
			var resB = op[2].read()
			if !resB.front():
				halt(resB.back())
				return
			opB = resB.back()
		
		match op.front():
			'mov':
				var res = op[1].write(opB)
				if !res.front():
					halt(res.back())
				next += 1
			'add':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() + opB)
				if !res.front():
					halt(res.back())
				next += 1
			'sub':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() - opB)
				if !res.front():
					halt(res.back())
				next += 1
			'mul':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() * opB)
				if !res.front():
					halt(res.back())
				next += 1
			'xor':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() ^ opB)
				if !res.front():
					halt(res.back())
				next += 1
			'and':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() & opB)
				if !res.front():
					halt(res.back())
				next += 1
			'or':
				var resA = op[1].read()
				if !resA.front():
					halt(resA.back())
					return
				var res = op[1].write(resA.back() | opB)
				if !res.front():
					halt(res.back())
				next += 1
			'not':
				var res = op[1].write(~opA)
				if !res.front():
					halt(res.back())
				next += 1
			'dec':
				var res = op[1].write(opA-1)
				if !res.front():
					halt(res.back())
				next += 1
			'inc':
				var res = op[1].write(opA+1)
				if !res.front():
					halt(res.back())
				next += 1

class Executor:
	var cpu: Cpu
	func _init():
		cpu = Cpu.new()
	# return tuple: [status, result]
	func getIntRegWrapper(token: String) -> Array:
		if cpu.regs.has(token):
			return [ParceResult.Ok, regAccessWrapper.new(cpu, token)]
		elif token.is_valid_int():
			return [ParceResult.Ok, intAccessWrapper.new(token.to_int())]
		else:
			return [ParceResult.Error, "Expected register or integer but %s found" % [token]]
	# return tuple: [status, result, nextIdx]
	func parceArg(tokens: Array[String], index: int) -> Array:
		#args can be number, register or indirect memory acccess '[]'
		if tokens[index].is_valid_int():
			return [ParceResult.Ok, intAccessWrapper.new(tokens[index].to_int()), index+1]
		if cpu.regs.has(tokens[index]):
			return [ParceResult.Ok, regAccessWrapper.new(cpu, tokens[index]), index+1]
		if tokens[index] == '[':
			if tokens[index+2] == ']':
				var argA = getIntRegWrapper(tokens[index+1])
				if argA.front() != ParceResult.Ok:
					return argA
				return [ParceResult.Ok, memoryAccessIndirectOneArg.new(cpu, argA[1]), index+3]
			elif tokens[index+2] == '+':
				var argA = getIntRegWrapper(tokens[index+1])
				if argA.front() != ParceResult.Ok:
					return argA
				var argB = getIntRegWrapper(tokens[index+3])
				if argB.front() != ParceResult.Ok:
					return argB
				return [ParceResult.Ok, memoryAccessIndirectTwoArgs.new(cpu, argA[1], argB[1]), index+5]
			else:
				return [ParceResult.Error, "Expected or ']' or '+' %s found" % [tokens[index+2]], index]
		else:
			return [ParceResult.Error, "Can't parce arg: %s" % [tokens[index]]]

	# in a good way it should be tokenizer and constructing abstract syntax tree
	# but let's use some hacks with replace and linear line parsing here
	# it should work fine in our case AFAIS
	func parceLine(line: String) -> Array:
		if line.is_empty() ||  line[0] == "#":
			return [ParceResult.Skip, null]
		var tokens = line.replace(',', ' ') \
						.replace('\t', ' ') \
						.replace('+', ' + ') \
						.replace(']', ' ] ') \
						.replace('[', ' [ ') \
						.split(" ", false)
		if (tokens.is_empty()):
			return [ParceResult.Skip, null]

		if oneArgOpcodes.has(tokens[0]):
			var pArg = parceArg(tokens, 1)
			if pArg.front() != ParceResult.Ok:
				return pArg
			return [ParceResult.Ok, tokens[0], pArg[1]]
		elif twoArgOpcodes.has(tokens[0]):
			var pArg1 = parceArg(tokens, 1)
			if pArg1.front() != ParceResult.Ok:
				return pArg1
			# TODO: check type!
			var pArg2 = parceArg(tokens, pArg1.back())
			if pArg2.front() != ParceResult.Ok:
				return pArg2
			return [ParceResult.Ok, tokens[0], pArg1[1], pArg2[1]]
		elif 'nop' == tokens[0]:
			return [ParceResult.Skip, null]
		else:
			return [ParceResult.Error, "Unknown command in line: %s" % [line]]

	func parser(codeEdit: CodeEdit):
		var commands = Array()
		for i in range(0, codeEdit.get_line_count()):
			var res = parceLine(codeEdit.get_line(i).to_lower())
			if res.front() == ParceResult.Skip:
				continue
			if res.front() == ParceResult.Error:
				#show msg error
				print(res)
				return [ParceResult.Error, res.back()]
			if res.front() == ParceResult.Ok:
				res.pop_front()
				commands.push_back(res)
		return [ParceResult.Ok, commands]
	
	func execute(prog):
		cpu.execute(prog)
	
	func executionErrorMsg():
		return cpu.errorMsg

func runTesting():
	var executor = Executor.new()
	var prog = executor.parser($CodeEdit)
	print(prog)
	if prog.front() != ParceResult.Ok:
		return
	executor.execute(prog[1])

func initMemoryViewer():
	const baseAddr = 0xBEA00
	const lineLen = 20
	const lines = 1024
	const elements = lineLen * lines
	const texts = [
		'''I'm hidding my messages in some regions of memory, hope someone can find it.''',
		'''Broken build of AceZero game was uploaded to servers by purpose''',
		'''I guess they find it and replace it with working version quite fast''',
		'''Hope you can find a more details in encrypted file which I hided in my account on gi''',
		'''can't write password directly it can be detected by firewalls''',
		'''[a-z]nickname can be used to decode it even with this funny CPU''',
		'''Good luck than, be careful, they are watching and don't dare to go hollow'''
	]
	var textsSz = 0
	for s in texts:
		textsSz += s.length()
	var filler = elements - textsSz
	var fillerPortion = filler / texts.size()
	var fillerReminder = elements - (fillerPortion*texts.size() + textsSz)
	
	var rng = RandomNumberGenerator.new()

	var data = Array()
	for section in range(0, texts.size()):
		for _j in range(0, fillerPortion):
			data.push_back(rng.randi_range(0, 255))
		for j in range(0, texts[section].length()):
			data.push_back(texts[section].unicode_at(j))
	for _j in range(0, fillerReminder):
			data.push_back(rng.randi_range(0, 255))

	var mem = $MemoryTextEdit
	for i in range(0, lines):
		var line = "%X:" % [baseAddr + i*lineLen]
		for j in range(0, lineLen):
			line += ' %02X' % [data[i*lineLen + j]]
		line += '|'
		for j in range(0, lineLen):
			var val = data[i*lineLen + j]
			# reference: https://en.cppreference.com/w/cpp/string/byte/isprint
			if val >= 32 && val <= 126:
				line += ' %c' % [data[i*lineLen + j]]
			else:
				line += ' .'
		mem.insert_line_at(i, line)

#region Quests
class LineFunc:
	var tests = [
		[{'ax':0, 'bx':0, 'dx':0}, 0],
		[{'ax':1, 'bx':1, 'dx':1}, 2],
		[{'ax':-1, 'bx':1, 'dx':1}, 0],
		[{'ax':2, 'bx':-2, 'dx':1}, 0],
		[{'ax':5, 'bx':10, 'dx':1}, 15]
	]
	func description() -> String:
		return """Seems first missing part which we should implement is a function to calculate linear function
FYI we should calculate function y=A*x+B
Input:
	A in ax
	B in bx
	x in dx
Result:
	should be stored in ax register
BTW, you can check information about x68, registers and commands in e-browser"""
	# return: [true/false, 'message' if false]
	func run(codeEdit: CodeEdit) -> Array:
		var executor = Executor.new()
		var prog = executor.parser(codeEdit)
		if prog.front() != ParceResult.Ok:
			return [false, prog.back()]
		for testcase in tests:
			executor.cpu.regs.merge(testcase.front(), true)
			executor.execute(prog[1])
			if !executor.executionErrorMsg().is_empty():
				return [false, executor.executionErrorMsg()]
			if executor.cpu.regs['ax'] != testcase.back():
				return [false, "For input: ax:%d bx:%d dx:%d expected result is ax:%d but %d received" % [testcase.front()['ax'], testcase.front()['bx'], testcase.front()['dx'], testcase.back(), executor.cpu.regs['ax']]]
		return [true]
#  solution:
# mul ax, dx
# add ax, bx

class DeterminantFunc:
	var tests = [
		[[1, 4, 4, 1], -15],
		[[0, 7, 4, 2], -28],
		[[5, 7, 4, 2], -18],
		[[5, 6, 4, 5], 1],
		[[0, 0, 0, 0], 0]
	]
	func description() -> String:
		return """And the last one should be implemented a code to calculate determinant of matrix 2x2
Matrix is a square array of table of numbers:
	| A B |
	| C D |
In memory they are located row by row. Element A has a base_address passed to function, B has a base_address+1 address...
To calculate determinant for 2x2 matrix we can use formula: A*D-B*C
Input:
	base_address of matrix in ax
Output:
	address to store result in dx
FYI, to acces value in memory you should use `[` `]` around expression, like: [dx] or [ax+2]
"""
	# return: [true/false, 'message' if false]
	func run(codeEdit: CodeEdit) -> Array:
		var executor = Executor.new()
		var prog = executor.parser(codeEdit)
		if prog.front() != ParceResult.Ok:
			return [false, prog.back()]

		var rng = RandomNumberGenerator.new()
		var inputAddr = rng.randi_range(0, 2048)
		var outputAddr = rng.randi_range(inputAddr+2, (inputAddr+2)*2)
		executor.cpu.addMemReg(inputAddr, 4, Access.r)
		executor.cpu.addMemReg(outputAddr, 1, Access.rw)
		for testcase in tests:
			var i = 0
			for val in testcase.front():
				executor.cpu.memory[i + inputAddr] = val
				i += 1
			executor.cpu.regs['ax'] = inputAddr
			executor.cpu.regs['dx'] = outputAddr
			executor.execute(prog[1])
			if !executor.executionErrorMsg().is_empty():
				return [false, executor.executionErrorMsg()]
			if executor.cpu.memory[outputAddr] != testcase.back():
				return [false, "For matrix:\n\t%2d %2d\n\t%2d %2d\nexpected result is %d but %d observed" % \
				[testcase.front()[0], testcase.front()[1], testcase.front()[2], testcase.front()[3], testcase.back(), executor.cpu.memory[outputAddr]]]
		return [true]
#  Solution
# mov bx, [ax]
# mul bx, [ax+3]
# mov cx, [ax+1]
# mul cx, [ax+2]
# sub bx, cx
# mov [dx], bx

class ParabolaFunc:
	var tests = [
		# ax*dx + bx*dx + cx
		[{'ax':1, 'bx':1, 'cx':1, 'dx':1}, 3],
		[{'ax':2, 'bx':1, 'cx':1, 'dx':2}, 11],
		[{'ax':1, 'bx':10, 'cx':0, 'dx':0}, 0],
		[{'ax':1, 'bx':1, 'cx':-4, 'dx':-1}, -4],
	]
	func description() -> String:
		return """Next one should be implemented calculation of parabola equation.
y = Ax^2 + Bx + C
Input:
	A in ax
	B in bx
	C in cx
	x in dx
Output:
	y should be stored in cx register
"""

	# return: [true/false, 'message' if false]
	func run(codeEdit: CodeEdit) -> Array:
		var executor = Executor.new()
		var prog = executor.parser(codeEdit)
		if prog.front() != ParceResult.Ok:
			return [false, prog.back()]
		for testcase in tests:
			executor.cpu.regs.merge(testcase.front(), true)
			executor.execute(prog[1])
			if !executor.executionErrorMsg().is_empty():
				return [false, executor.executionErrorMsg()]
			if executor.cpu.regs['cx'] != testcase.back():
				return [false, "For input: ax:%d bx:%d cx:%d dx:%d expected result is cx:%d but %d received" % [testcase.front()['ax'], testcase.front()['bx'], testcase.front()['cx'], testcase.front()['dx'], testcase.back(), executor.cpu.regs['cx']]]
		return [true]
#  Solution
# mul bx, dx
# add cx, bx
# mov bx, dx
# mul dx, dx
# mul ax, dx
# add cx, ax
#endregion

var quests = [LineFunc.new(), ParabolaFunc.new(), DeterminantFunc.new()]

func _ready():
	initMemoryViewer()
	if Global.CrashSeen:
		for i in range(0, Global.DbgLastCode.size()):
			$CodeEdit.set_line(i, Global.DbgLastCode[i])
		$TopLabel.text = "dbgAI - Ace0.exe (x68 CPU)"
		$AiText.text = '''Hi!
I noted you faced an application crash! That's good! I started debugging sessinon for you to fix it!\n''' + quests[Global.DbgCurrentProblemIdx].description()

func _on_exit_button_pressed():
	Global.DbgLastCode = []
	for i in range(0, $CodeEdit.get_line_count()):
		Global.DbgLastCode.push_back($CodeEdit.get_line(i))
	self.queue_free()

func _on_texture_button_pressed():
	if Global.CrashSeen:
		var res = quests[Global.DbgCurrentProblemIdx].run($CodeEdit)
		print(res)
		if res.front():
			Global.DbgCurrentProblemIdx += 1
			if Global.DbgCurrentProblemIdx == quests.size():
				Global.DbgCurrentProblemIdx = 0
				Global.RunEnding(Global.Endings.BadAss)
			$AiText.text = quests[Global.DbgCurrentProblemIdx].description()
		else:
			$AiText.text = res.back() + '\n\n' + quests[Global.DbgCurrentProblemIdx].description()
	else:
		$AiText.text = 'Nothing to run right now'
