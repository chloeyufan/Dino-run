extends KinematicBody2D

signal death
signal IframesS
signal turnArmorOff

const UP_DIRECTION =Vector2.UP

export var speed = 600

export var jump_strength = 1000.0
export var maximum_jumps = 1
export var double_jump_strenth = 800.0
export var gravity =3000.0

export var life_meter = 1
var Iframes = 0

var jumps_made = 0
var velocity = Vector2.ZERO
var screen_size
var is_alive = true
var start_pos

func _ready():
	
	screen_size = get_viewport_rect().size
	start_pos = position

#this is the movement function but idk why I named it dealing_jump
func dealing_jump(delta: float):
	
	if is_alive:
	
		var horizontal_direction = (Input.get_action_strength("move_right")-Input.get_action_strength("move_left"))
		
		velocity.y +=gravity*delta
		velocity.x = horizontal_direction*speed
		velocity = move_and_slide(velocity, UP_DIRECTION)
		
		var is_falling = velocity.y > 0.0 and not is_on_floor()
		var is_jumping = Input.is_action_just_pressed("jump") and is_on_floor()
		var is_double_jumping = Input.is_action_just_pressed("jump") and is_falling
		var is_jump_cancelled = Input.is_action_just_pressed("jump") and velocity.y < 0.0
		var is_idling = is_on_floor()
		
		if is_jumping:
			jumps_made+=1
			velocity.y = -jump_strength
		elif is_double_jumping:
			jumps_made+=1
			if jumps_made <= maximum_jumps:
				velocity.y = -double_jump_strenth
		elif is_jump_cancelled:
			velocity.y = 0.0
		elif is_idling:
			jumps_made = 0
		
#well make the dino able to die of course
func die():
	is_alive = false
	position.y = start_pos.y
	emit_signal("death")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_alive:
		$AnimatedSprite.play()
		$AnimatedSprite.animation = "running"
	else:
		$AnimatedSprite.animation = "death"
	
	dealing_jump(delta)
	
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	Iframes -= 1
	

func _check_armor():
	life_meter -= 1
	if life_meter < 1:
		die()
		maximum_jumps = 1
	Iframes = 10
	emit_signal("turnArmorOff")

#detect emeny collison
func _on_Enemy_detect_body_entered(body):
	if "Police" in body.name and Iframes <= 0:
		_check_armor()
		#emit_signal("IframesS")
	elif "Enemies" in body.name and Iframes <= 0:
		_check_armor()



func _on_CanvasLayer_restart():
	#reset everthing
	position = start_pos
	is_alive = true


func _on_CanvasLayer_Quit():
	get_tree().quit()

#set new max jumps to 3
func _on_JumpUpgrade_Upgrade_jump():
	maximum_jumps = 2

func _on_ArmorUp_ArmorDoThing():
	life_meter += 1 
