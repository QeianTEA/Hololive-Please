extends Area2D
var noStuck = false

func _on_body_entered(body):
	if body.is_in_group("Papers"):
		body.sizechange(false)


func _on_body_exited(body):
	if body.is_in_group("Papers"):
		body.sizechange(true)
