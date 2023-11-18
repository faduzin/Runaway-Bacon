extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const AIR_FRICTION := 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction

func _physics_process(delta):
	# Add the gravity.
	velocity.x = 0
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * SPEED,AIR_FRICTION)
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction == -1:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("Run")
	
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("Run")
	
	if direction == 0:
		$AnimatedSprite2D.play("default")
		
	
	
	move_and_slide()
	
	
func _set_state():
	var state = "defaut"
		
	if !is_on_floor():
		state = "Jump"
	elif  direction != 0:
		state = "Run"
		
	if($AnimatedSprite2D.name != state):
		$AnimatedSprite2D.play(state)
		
		
