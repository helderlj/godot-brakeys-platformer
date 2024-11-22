extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0

var can_jump := false
var coyote_time = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var coyote_timer: Timer = $Coyote
@onready var jump: AudioStreamPlayer2D = $Jump


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		coyote_timer.start()
		velocity += get_gravity() * delta


	# Handle jump.
	if is_on_floor() and !can_jump:
		can_jump = true
	elif can_jump and coyote_timer.is_stopped():
		coyote_timer.start(coyote_time)
	
	if can_jump:
		if Input.is_action_just_pressed("jump") and can_jump:
			velocity.y = JUMP_VELOCITY
			jump.play()
			can_jump = false

		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
		
	if is_on_floor():
		if direction > 0:
			animated_sprite.flip_h  = false
		elif direction < 0:
			animated_sprite.flip_h  = true
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		

	move_and_slide()


func _on_coyote_timeout() -> void:
	can_jump = false
