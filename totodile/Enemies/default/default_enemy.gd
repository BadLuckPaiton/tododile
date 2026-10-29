extends CharacterBody2D
@export var speed = 300;
@export var health = 10;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_position = _get_target();
	var direction = (target_position - global_position).normalized()
	velocity = direction * speed
	move_and_slide()
	_check_health();
	pass

func _check_health():
	if health<=0:
		queue_free()
	pass;

func _get_target():
	var players_info= get_tree().get_nodes_in_group("player")
	return players_info[0].position;

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		health-=1;
		area.queue_free()
	pass # Replace with function body.
