extends Node

export (PackedScene) var coming_car
var score = 0
var lastPosittion = "derecha"
var Velocity = Vector2(0, 0)
var dont_respond = false
signal start

#movement
func _process(_delta):
	if not $AnimationPlayer.is_playing() and dont_respond == false:
		if Input.is_action_pressed("ui_right") and lastPosittion != "derecha":
			$AnimationPlayer.play("derecha")
			lastPosittion = "derecha"
		if Input.is_action_pressed("ui_left") and lastPosittion != "izquierda":
			$AnimationPlayer.play("izquierda")
			lastPosittion = "izquierda"
	
#car spawner
func _on_cars_timeout():
	#doesn't work :/
	var offset = [0.25, 0.75] #list to choose from
	$Path2D/PathFollow2D.unit_offset = offset[randi() % offset.size()]
	var Car = coming_car.instance()
	add_child(Car)
	Car.position = $Path2D/PathFollow2D.position
	Car.set_linear_velocity(Vector2(0, 0))
	score += 1
	$CanvasLayer/score.text = str(score)
	if $cars.wait_time >= 0.3:
		$cars.wait_time -= 0.01
	
#game over
func _on_player_body_entered(_body):
	$cars.stop() 
	$effect.stop()
	$road.playing = false
	$CanvasLayer/ColorRect.visible = true
	$player.visible = false
	$CanvasLayer/gameOverScreen.visible = true
	$CanvasLayer/startButton.visible = true
	$AnimationPlayer.play("fade in out")
	$CanvasLayer/LinkButton.visible = true
	$eyes.visible = false
	$CanvasLayer/fiqus.visible = true

#effects
func _on_effect_timeout():
	$effect_stopper.start()
	$effect.wait_time -= 0.1
	var effects = ["obscure_vission", "random_turn", "dont_respond", "fade"]
	var choice = effects[randi() % effects.size()]
	$road.speed_scale += 0.5
	match choice:
		"obscure_vission":
			$CanvasLayer/block_vission.set_visible(true)
			$eyes.animation = "semi closed"
		"dont_respond":
			dont_respond = true 
			$eyes.animation = "z"
		"random_turn":
			if lastPosittion != "derecha":
				Input.action_press("ui_right")
			if lastPosittion != "izquierda":
				Input.action_press("ui_left")
			$eyes.animation = "wheel"
		"fade":
			$AnimationPlayer.play("fade in out")
			$eyes.animation = "closed"
	print("fx")

#effect stopper
func _on_effect_stopper_timeout():
	$CanvasLayer/block_vission.set_visible(false)
	dont_respond = false
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	$eyes.animation = "eyes open"
	

func _on_world_start():
	$cars.start() 
	$effect.start()
	$road.playing = true
	$CanvasLayer/ColorRect.visible = false
	$player.visible = true
	$CanvasLayer/startButton.visible = false
	$CanvasLayer/gameOverScreen.visible = false
	score = 0
	$cars.wait_time = 2
	$eyes.animation = "eyes open"
	$CanvasLayer/LinkButton.visible = false
	$eyes.visible = true
	$CanvasLayer/fiqus.visible = false
	

func _on_startButton_pressed():
	emit_signal("start")
	$AnimationPlayer.play("fade in out")


func _on_LinkButton_pressed():
	OS.shell_open("https://youtu.be/NdBVOTNSjxQ") 
	print("link")

