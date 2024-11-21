extends Node2D

@onready var ray_cast_right: RayCast2D = $RayCast2DRight
@onready var ray_cast_left: RayCast2D = $RayCast2DLeft
@onready var ray_under: RayCast2D = $RayCast2DUnder
@onready var collision_shape_2d: CollisionShape2D = $Killzone/CollisionShape2D


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 60
var direction = 1

func _physics_process(delta: float) -> void:
	
	if !ray_under.is_colliding(): 
		if direction == 1:
			ray_under.position.x *= -1
			animated_sprite.flip_h = true
			direction = -1 
		else:
			ray_under.position.x *= -1
			animated_sprite.flip_h = false
			direction = 1
			
	

	if ray_cast_right.is_colliding():
		animated_sprite.flip_h = true
		direction = -1
		ray_under.position.x *= -1
	if ray_cast_left.is_colliding():
		animated_sprite.flip_h = false
		direction = 1
		ray_under.position.x *= -1
	
	position.x += direction * SPEED * delta
