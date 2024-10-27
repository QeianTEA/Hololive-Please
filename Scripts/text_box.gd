extends MarginContainer

@export var label = Label
var textLabel: String : set = setText
var allignment



func setText(v: String):
	label.text = v
	
	if allignment:
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	else:
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	

