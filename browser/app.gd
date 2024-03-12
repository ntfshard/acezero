extends ColorRect

var threshold = 0.5

var database = {
	"ace": "Ace Zero was released with bug, you can contact support through about page in main menu",
	"acerola": "Game Dev Graphics Youtuber",
	"art": "Art is a diverse range of human activity and its resulting product that involves creative or imaginative talent generally expressive of technical proficiency, beauty, emotional power, or conceptual ideas.",
	"anime": "*CLICK* Nice",
	"bird": "Birds Aren't Real is a theory which posits that birds are actually drones operated by the United States government to spy on American citizens.",
	"bottle": "Bottle and Eggsy is a new game of rdworlds game studio",
	"box": "NO PLACE FOR HIDEO",
	"cat": "Fluffy furball which can destroy entire universe just with one sight",
	"chalkeaters": "The Chalkeaters is an English-language musical group that composes comedy songs about video games",
	"castle": "Or old fancy house, or character from some game",
	"chaos": "Chaos is a primeval entity that has existed since the beginning of the universe and the overarching antagonist of the Sailor Moon series.",
	"cthulhu": "Cthulhu es una entidad cósmica creada por el escritor estadounidense de terror Howard Phillips Lovecraft y representada por primera vez en el cuento La llamada de Cthulhu, publicado en la revista estadounidense Weird Tales en 1928. Considerado un Primigenio dentro de las entidades cósmicas, la criatura ha aparecido desde entonces en numerosas referencias de la cultura popular. Cthulhu es descrito como la convergencia entre un pulpo, un dragón y una criatura de forma humanoide.",
	"clown": "Il pagliaccio, chiamato anche, con un anglicismo, clown (derivato dall'islandese klunni 'goffo'), è quel personaggio che ha il compito di divertire gli spettatori, specie negli spettacoli circensi. Esistono diversi tipi di pagliacci: quello più conosciuto è il cosiddetto pagliaccio 'augusto', vestito in modo buffo e sgargiante, ma esiste anche il pagliaccio 'bianco, romantico e vestito in modo più sobrio.",
	"dbgai": "Software debuuging tool with AI assistant",
	"death": "Death imitates art",
	"determinant":"""In mathematics, the determinant is a scalar value that is a function of the entries of a square matrix. The determinant of a matrix A is commonly denoted det(A), det A, or |A|. Its value characterizes some properties of the matrix and the linear map represented, on a given basis, by the matrix. In particular, the determinant is nonzero if and only if the matrix is invertible and the corresponding linear map is an isomorphism. The determinant of a product of matrices is the product of their determinants.
The determinant of a 2 × 2 matrix is
|a b|
|c d| = ad-bc
and the determinant of a 3 × 3 matrix is
|a b c|
|d e f| = aei + bfg + cdh - ceg - bdi - afh
|g h i|
The determinant of an n × n matrix can be defined in several equivalent ways, the most common being Leibniz formula, which expresses the determinant as a sum of 
n! (the factorial of n) signed products of matrix entries. It can be computed by the Laplace expansion, which expresses the determinant as a linear combination of determinants of submatrices, or with Gaussian elimination, which expresses the determinant as the product of the diagonal entries of a diagonal matrix that is obtained by a succession of elementary row operations.

Determinants can also be defined by some of their properties. Namely, the determinant is the unique function defined on the n × n matrices that has the four following properties:
\t1.The determinant of the identity matrix is 1.
\t2.The exchange of two rows multiplies the determinant by −1.
\t3.Multiplying a row by a number multiplies the determinant by this number.
\t4.Adding to a row a multiple of another row does not change the determinant.
The above properties relating to rows (properties 2-4) may be replaced by the corresponding statements with respect to columns.""",
	"dog": "Custom version of wolfs",
	"souls": "git gut",
	"f": "respect",
	"fire": "State of buttocks afte loosing in any online game",
	"fox": "Foxes live on every continent except Antarctica",
	"game": "A game is a structured type of play, usually undertaken for entertainment or fun, and sometimes used as an educational tool.[1] Many games are also considered to be work (such as professional players of spectator sports or games) or art (such as jigsaw puzzles or games involving an artistic layout such as Mahjong, solitaire, or some video games)",
	"google": "10,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000,​000",
	"hamster": "Hamster may refer to a rodent, a British band, a name used by Richard Hammond (born 1969), an English television presenter or Hamster Monogatari 64 is a life simulation game for the Nintendo 64",
	"helldivers": "Pew Pew Pew",
	"jam": "Yes, jams! Yam jams, fig jams... A-and date jams! Seedless, delicious, ex-exotic jams!",
	"jester": "Stańczyk (Full title: Stańczyk during a ball at the court of Queen Bona in the face of the loss of Smolensk, Polish: Stańczyk w czasie balu na dworze królowej Bony wobec straconego Smoleńska) is a painting by Jan Matejko finished in 1862. Stańczyk remains an important symbol of Polish culture. Stańczyk embodied satire to criticize social problems while also offering wisdom to the common people. His character is remembered and is a proud part of Polish national character.",
	"knights": "Do you know why it was called the Dark Ages? Because there were so many knights!",
	"life": "Einmal ist keinmal, says Tomas to himself. What happens but once, says the German adage, might as well not have happened at all. If we have only one life to live, we might as well not have lived at all.",
	'line': """In calculus and related areas of mathematics, a linear function from the real numbers to the real numbers is a function whose graph (in Cartesian coordinates) is a non-vertical line in the plane.
Linear functions are related to linear equations. A linear equation in one variable x can be written as ax+b=0 where a!=0""",
	'love': 'Well-known bad password',
	"master": "A well-known (literally)underground craftsman and very nice guy from upcoming game",
	"meme": "A meme is an idea, behavior, or style that spreads by means of imitation from person to person within a culture and often carries symbolic meaning representing a particular phenomenon or theme. A meme acts as a unit for carrying cultural ideas, symbols, or practices, that can be transmitted from one mind to another through writing, speech, gestures, rituals, or other imitable phenomena with a mimicked theme. Supporters of the concept regard memes as cultural analogues to genes in that they self-replicate, mutate, and respond to selective pressures. In popular language, a meme may refer to an Internet meme, typically an image, that is remixed, copied, and circulated in a shared cultural experience online.",
	"minesweeper": "Minesweeper is a logic puzzle video game genre generally played on personal computers. The game features a grid of clickable tiles, with hidden 'mines' (depicted as naval mines in the original game) scattered throughout the board. The objective is to clear the board without detonating any mines, with help from clues about the number of neighboring mines in each field.",
	"molejuice": "Exquisite and very rare boose which produces in 5 liters glass jars",
	"moon": "月",
	"ntfshard": "0x647261687366746e",
	"ntfs.hard": "7237954652378395758",
	"opengl": "Videocard goes brrrr",
	"palworld": "Furry creatures goes brrr",
	"parabola": """In mathematics, a parabola is a plane curve which is mirror-symmetrical and is approximately U-shaped. It fits several superficially different mathematical descriptions, which can all be proved to define exactly the same curves.
The graph of a quadratic function y=ax^2+bx+c is a parabola if a!=0, and, conversely, a parabola is the graph of a quadratic function if its axis is parallel to the y-axis.""",
	"phong": "The Phong reflection model (also called Phong illumination or Phong lighting) is an empirical model of the local illumination of points on a surface designed by the computer graphics researcher Bui Tuong Phong",
	"racoon": "Or trash panda, or City. Mystery",
	"reznov": "youtube.com/user/MUHnukem",
	"robot": "Mr. Robot is an American drama thriller television series created by Sam Esmail for USA Network. It stars Rami Malek as Elliot Alderson, a cybersecurity engineer and hacker with social anxiety disorder, clinical depression and dissociative identity disorder. Elliot is recruited by an insurrectionary anarchist known as 'Mr. Robot', played by Christian Slater, to join a group of hacktivists called 'fsociety'. The group aims to destroy all debt records by encrypting the financial data of E Corp, the largest conglomerate in the world.",
	"sh": "Als Schumann-Resonanz (benannt nach dem deutschen Physiker und Elektroingenieur Winfried Otto Schumann) bezeichnet man das Phänomen, dass elektromagnetische Wellen bestimmter Frequenzen entlang des Umfangs der Erde stehende Wellen bilden.",
	"shader": "シェーダー とは、3次元コンピュータグラフィックスにおいて、シェーディング（陰影処理）を行うコンピュータプログラムのこと。「shade」とは「次第に変化させる」「陰影・グラデーションを付ける」という意味で、「shader」は頂点色やピクセル色などを次々に変化させるもの（より具体的に、狭義の意味で言えば関数）を意味する。",
	"sorrow": '''Твой дом стал для тебя западней,
Ты не услышишь морской прибой,
Дорога в никуда
Будет с тобою навсегда...

Твоя грусть пронзит облака
Ты не увидишь свет вдалеке
Ты захочешь уснуть на века
И утонешь в глубокой реке.''',
	"stone": "I'll give you leverage, not a stone",
	"streamer": "Streamer bass is a bass guitar manufactured by the Warwick company and launched in 1982.",
	"tbb": "Threading building blocks is a C++ parallel runtime",
	"vr": "A voltage regulator is a system designed to automatically maintain a constant voltage. It may use a simple feed-forward design or may include negative feedback. It may use an electromechanical mechanism, or electronic components. Depending on the design, it may be used to regulate one or more AC or DC voltages.",
	"water": "Much more simpler version of vodka",
	"x86": "It's x68!",
	"zero": "0",
	"123": "456",
	"34": "Rule of internet",
	"42": "Answer!",
	"69": "Nice!",
	"e": "2.71828 18284 59045 23536 02874 71352 66249 77572 47093 69995 95749 66967 62772 40766 30353 54759 45713 82178 52516 64274 27466 39193 20030 59921 81741 35966 29043 57290 03342 95260 59563 07381 32328 62794 34907 63233 82988 07531 95251 01901 15738 34187 93070 21540 89149 93488 41675 09244 76146 06680 82264 80016 84774 11853 74234 54424 37107 53907 77449 92069 55170 27618 38606 26133 13845 83000 75204 49338 26560 29760",
	"pi": "3.1415926535 8979323846 2643383279 5028841971 6939937510 5820974944 5923078164 0628620899 8628034825 3421170679",
	"0": "Zero",
	"0.3": "Actually it's 0.30000000000000004",
	
	## add assembly-related help here for dbg quest
	"x68": """X68 CPU overview
It's a general purpose series CPU with 4 registers and various
assembly commands like mov, add, sub, mul, inc, dec, xor, or, and, nop...
It has a Harward memory model with flat addresses.
Each memory address can be protected to access by using 3 different access flags: no_access, read_only, read_write""",
	"mov": """mov ax, 2\tmove to ax register value 2
mov dx, bx\tmove to dx register value in bx
mov [ax], dx\tmove to memory by address stored in ax value in dx register
mov cx, [ax + bx]\tmove to register cx value from memory by address of sum ax and bx registers
mov dx, [cx+1]\tmove to register dx value from memory by address of sum cx and 1

Same argument format can be used for other assembly instructions of x68 CPU""",
	"add": """Add 2 value, store result in first argument
add ax, 2\tadds 2 to value in register ax
add cx, bx\tadds to value in cx value in bx""",
	"sub": """Substitute 2 value, store result in first argument
sub dx, 3\tdx = dx - 3
sub dx, cx\tdx = dx - cx""",
	"inc": """Increment value in first argument by 1
inc [ax]\tincrement value in memory by address stored in ax by one, equivalent to add [ax], 1
inc cx\tcx = cx + 1""",
	"dec": """Decrease value in first argument by 1
dec [dx]\tdecrement value in memory by address stored in dx by one, equivalent to sub [dx], 1
dec bx\tbx = bx - 1""",
	"mul": """Multiplcate 2 value, store result in first argument
mul ax, bx\tax = ax * bx
mul dx, 16\tdx = dx * 16""",
	"xor": """Bitwise XOR operation, aslo called exclusive or. Using 2 same arguments is a well-known trick by writing zero\nVery often used as a simple symmetric key encryption
x|y|xor
0|0|0
0|1|1
1|0|1
1|1|0""",
	"and": """Bitwise AND operation between two arguments, store value in first one
x|y|and
0|0|0
0|1|0
1|0|0
1|1|1""",
	"or": """Bitwise OR operation between two arguments, store value in first one
x|y|or
0|0|0
0|1|1
1|0|1
1|1|1""",
	"not": """Bitwise NOT operation of one argument
x|not
0|1
1|0""",
	"nop": """No operation, doesn't have side effects, can be used for memory alignment""",
	"register": """x68 CPU registers
x68 CPU has 4 general registers: ax, bx, cx, dx
Each of them can be used for storing values (like numbers) or addresses for making indirect access, see mov for more details"""
}

func sort_descent(a, b):
	return a[0] > b[0]

func urlRequest(text: String):
	if text.contains('42-42-564.jp'):
		add_child(preload("res://browser/shinigami.tscn").instantiate())
		return

	var request = text.to_lower().split(" ", false)
	var result = Array()
	
	for word in request:
		for key in database.keys():
			var cmpres = word.similarity(key)
			if cmpres >= threshold:
				result.push_back([cmpres, key])

	if result.is_empty():
		$BodyRichText.set_text("Nothing found for this request :(")
	else:
		result.sort_custom(sort_descent)
		var joinedTxt = "We found someting similar to your keywords in such articles:\n\n"
		for pair in result:
			joinedTxt += pair.back() + ": " + database[pair.back()] + "\n\n"
		$BodyRichText.set_text(joinedTxt)

func _on_url_line_edit_text_submitted(new_text):
	urlRequest(new_text)

func _on_go_button_pressed():
	urlRequest($UrlLineEdit.text)

func _on_close_button_pressed():
	self.queue_free()

func _ready():
	$UrlLineEdit.grab_focus()
