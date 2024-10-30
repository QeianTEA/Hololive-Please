extends ParallaxLayer


@export var Maxspeed: float
var speed: float

func _process(delta):
	self.motion_offset.x += speed * delta

func SpeedModification(hello:int):
	speed = Maxspeed * hello

func SpeedZero():
	speed = 0
