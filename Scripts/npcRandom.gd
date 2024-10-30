extends Sprite2D

##Variables...
var clothes0 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes1.png")
var clothes1 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes2.png")
var clothes2 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes3.png")
var clothes3 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes4.png")
var clothes4 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes5.png")
var clothes5 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes6.png")
var clothes6 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes7.png")
var clothes7 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes8.png")
var clothes8 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes9.png")
var clothes9 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes10.png")
var clothes10 = preload("res://Sprites/Characters/Generic NPC sprite/Clothes/clothes11.png")

var eye0 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes1.png")
var eye1 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes2.png")
var eye2 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes3.png")
var eye3 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes4.png")
var eye4 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes5.png")
var eye5 = preload("res://Sprites/Characters/Generic NPC sprite/Eyes/eyes6.png")

var hair0 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair1.png")
var hair1 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair2.png")
var hair2 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair3.png")
var hair3 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair4.png")
var hair4 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair5.png")
var hair5 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair6.png")
var hair6 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair7.png")
var hair7 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair8.png")
var hair8 = preload("res://Sprites/Characters/Generic NPC sprite/hair/hair9.png")


var mouth0 = preload("res://Sprites/Characters/Generic NPC sprite/Mouth/mouth1.png")
var mouth1 = preload("res://Sprites/Characters/Generic NPC sprite/Mouth/mouth2.png")
var mouth2 = preload("res://Sprites/Characters/Generic NPC sprite/Mouth/mouth3.png")
var mouth3 = preload("res://Sprites/Characters/Generic NPC sprite/Mouth/mouth4.png")
var mouth4 = preload("res://Sprites/Characters/Generic NPC sprite/Mouth/mouth5.png")
##

@onready var eyesSprite = $Eyes
@onready var mouthSprite = $Mouth
@onready var clothesSprite = $Clothes
@onready var hairSprite = $Hair

var eyes = []
var mouth = []
var clothes = []
var hair = []

var randomNum = 0
var npcScript
@export var randomColorRange = 150

func _ready():
	npcScript = get_parent()
	
	ConversationRandomizer()
	
	eyes.append(eye0)
	eyes.append(eye1)
	eyes.append(eye2)
	eyes.append(eye3)
	eyes.append(eye4)
	eyes.append(eye5)
	
	mouth.append(mouth0)
	mouth.append(mouth1)
	mouth.append(mouth2)
	mouth.append(mouth3)
	mouth.append(mouth4)
	
	clothes.append(clothes0)
	clothes.append(clothes1)
	clothes.append(clothes2)
	clothes.append(clothes3)
	clothes.append(clothes4)
	clothes.append(clothes5)
	clothes.append(clothes6)
	clothes.append(clothes7)
	clothes.append(clothes8)
	clothes.append(clothes9)
	clothes.append(clothes10)
	
	hair.append(hair0)
	hair.append(hair1)
	hair.append(hair2)
	hair.append(hair3)
	hair.append(hair4)
	hair.append(hair5)
	hair.append(hair6)
	hair.append(hair7)
	hair.append(hair8)
	
	eyesSprite.texture = eyes.pick_random()
	mouthSprite.texture = mouth.pick_random()
	clothesSprite.texture = clothes.pick_random()
	hairSprite.texture = hair.pick_random()
	
	hairSprite.self_modulate = RandomThatColor()
	self_modulate = hairSprite.self_modulate
	eyesSprite.self_modulate = hairSprite.self_modulate
	mouthSprite.self_modulate = hairSprite.self_modulate
	clothesSprite.self_modulate = RandomThatColor()
	
	var numScale = randf_range(1.15,1.65)
	get_parent().scale = Vector2(numScale,numScale)


func ConversationRandomizer():
	if !npcScript.specialGuest:
		var number = randi_range(0,20)
		match number:
			0:																       #LINE OF DEATH
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Finally."},
					{"speaker": "NPC", "text": "This queue is quite long you know?"},
					{"speaker": "NPC", "text": "I'm so happy I was able to come!"}]
			1:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "My legs hurt..."}]
			2,19,20:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Here."}]
			3:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "One moment... Ok."}]
			4:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "I thought there would be"},
					{"speaker": "NPC", "text": "more security at the entrance..."}]
			5:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Do I look like someone"},
					{"speaker": "NPC", "text": "who needs a ticket? I’m a VIP!"}]
			6:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "I didn’t know there would be"},
					{"speaker": "NPC", "text": "so much paperwork involved."}]
			7:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "I almost lost it on the train."},
					{"speaker": "NPC", "text": "Good thing I didn’t!"}]
			8:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "You’re really serious about this..."}]
			9:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "I almost lost it on the train."},
					{"speaker": "NPC", "text": "Good thing I didn’t!"}]
			10:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Do you have any idea"},
					{"speaker": "NPC", "text": "how long I waited for this day?!"}]
			11:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Can I get in with"},
					{"speaker": "NPC", "text": "just my Hololive love?"},
					{"speaker": "Player", "text": "No."},
					{"speaker": "NPC", "text": "Damn..."}]
			12:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Oh, I’m late, aren’t I?"},
					{"speaker": "NPC", "text": "Please tell me"},
					{"speaker": "NPC", "text": "I didn’t miss the best part already."}]
			13:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "Do you know who I am?"},
					{"speaker": "NPC", "text": "I’ve been to every HoloCon!"}]
			14:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."},
					{"speaker": "NPC", "text": "I’ve got a ticket... "},
					{"speaker": "NPC", "text": "But my friend doesn't."},
					{"speaker": "NPC", "text": "Can you let them in anyway?"},
					{"speaker": "NPC", "text": "He's somewhere in the line."},
					{"speaker": "NPC", "text": "I think?"}]
			15,16,17,18:
				npcScript.conversation = [{"speaker": "Player", "text": "Your Ticket."}]
		
		
		number = randi_range(0,21)
		match number:
			0:																       #LINE OF DEATH
				npcScript.convoApproved = [{"speaker": "Player", "text": "Seems good."},
					{"speaker": "NPC", "text": "Finally."},
					{"speaker": "NPC", "text": "Holocon!! Here I come!!!"}]
			1:
				npcScript.convoApproved = [{"speaker": "Player", "text": "You're good to go."},
					{"speaker": "NPC", "text": "Finally."},
					{"speaker": "NPC", "text": "Holocon!! Here I come!!!"}]
			2:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Welcome To Holocon1999"},
					{"speaker": "NPC", "text": "Finally."},
					{"speaker": "NPC", "text": "Holocon!! Here I come!!!"}]
			3:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Seems good."},
					{"speaker": "NPC", "text": "So EXCITED!"}]
			4:
				npcScript.convoApproved = [{"speaker": "Player", "text": "You're good to go."},
					{"speaker": "NPC", "text": "So EXCITED!"}]
			5:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Welcome To Holocon1999"},
					{"speaker": "NPC", "text": "So EXCITED!"}]
			6,7:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Seems good."}]
			8,9:
				npcScript.convoApproved = [{"speaker": "Player", "text": "You're good to go."}]
			10,11,12:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Welcome To Holocon1999"}]
			13:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Seems good."},
					{"speaker": "NPC", "text": "YES!"}]
			14:
				npcScript.convoApproved = [{"speaker": "Player", "text": "You're good to go."},
					{"speaker": "NPC", "text": "YES!"}]
			15:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Welcome To Holocon1999"},
					{"speaker": "NPC", "text": "YES!"}]
			16,21:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Seems good."},
					{"speaker": "NPC", "text": "Thanks."}]
			17,20:
				npcScript.convoApproved = [{"speaker": "Player", "text": "You're good to go."},
					{"speaker": "NPC", "text": "Thanks."}]
			18,19:
				npcScript.convoApproved = [{"speaker": "Player", "text": "Welcome To Holocon1999"},
					{"speaker": "NPC", "text": "Thanks."}]

func RandomThatColor():
	var newColor = Color(RandomThat(), RandomThat(), RandomThat())
	return newColor

func RandomThat():
	randomNum = randf_range(randomColorRange,255) / 255
	return randomNum
