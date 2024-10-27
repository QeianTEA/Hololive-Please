extends MarginContainer

@export var label = Label
@export var panel = Panel

var textLabel: String : set = setText
var allignment


func setText(v: String):
	label.text = v
	
	await resized
	
	if allignment:
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	else:
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_LEFT
	

