extends CharacterBody2D
@onready var bullet_scene = load("res://bullet/bullet.tscn");

@export var speed = 400

func get_input():
	look_at(get_global_mouse_position())
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate();
		bullet.position =global_position;
		bullet.bullet_direction = (position - get_global_mouse_position()).normalized()
		get_parent().add_child(bullet)

func _physics_process(delta):
	get_input()
	move_and_slide()
