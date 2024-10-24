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

@export var randomColorRange = 150

func _ready():
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
	clothesSprite.self_modulate = RandomThatColor()
	
	var numScale = randf_range(0.8,1.2)
	get_parent().scale = Vector2(numScale,numScale)


func RandomThatColor():
	var newColor = Color(RandomThat(), RandomThat(), RandomThat())
	return newColor

func RandomThat():
	var randomNum = 0
	randomNum = randf_range(randomColorRange,255) / 255
	return randomNum
