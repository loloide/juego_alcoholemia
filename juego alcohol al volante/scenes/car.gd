extends Area2D
var anim = ["1", "2", "3"] 
func _ready():
	$AnimatedSprite.animation = anim[randi() % anim.size()]
