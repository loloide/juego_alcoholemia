extends RigidBody2D
var anim = ["1", "2", "3"]
func _ready():
	$AnimatedSprite.animation = anim[randi() % anim.size()]
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
