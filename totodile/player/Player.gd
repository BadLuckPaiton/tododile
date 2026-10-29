extends CharacterBody2D
@onready var bullet_scene = load("res://bullet/bullet.tscn");

@export var speed = 400
@export var dash_speed_multiplier:float = 3.0

var health = 10;
var is_dashing:bool = false;
var can_dash:bool = true;
var dash_direction:Vector2= Vector2.ZERO;

@onready var dash_timer: Timer = $DashTimer;
@onready var dash_cooldown: Timer = $DashCooldown;

func _ready() -> void:
	dash_timer.timeout.connect(_on_dash_timer_timeout);
	dash_cooldown.timeout.connect(unblock_dash);

func get_input(input_direction:Vector2):
	look_at(get_global_mouse_position())
	velocity = input_direction * speed
	
	if Input.is_action_just_pressed("shoot"):
		var bullet = bullet_scene.instantiate();
		bullet.position =global_position;
		bullet.bullet_direction = (global_position - get_global_mouse_position()).normalized()
		get_parent().add_child(bullet)


func _physics_process(delta):
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	get_input(input_direction)
	if Input.is_action_just_pressed("dash") and can_dash and input_direction != Vector2.ZERO:
		start_dash(input_direction);
		print("Dash")
	if is_dashing:
		velocity = dash_direction * (speed*dash_speed_multiplier)
	else:
		if input_direction != Vector2.ZERO:
			velocity = input_direction*speed;
		else:
			velocity = velocity.move_toward(Vector2.ZERO,speed);
	move_and_slide()

func start_dash(direction: Vector2) -> void:
	is_dashing = true
	can_dash = false
	dash_direction = direction.normalized()
	
	dash_timer.start()
	dash_cooldown.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		health-=1;
	pass # Replace with function body.


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.

func _on_dash_timer_timeout() -> void:
	is_dashing = false
	
func unblock_dash() -> void:
	can_dash = true
