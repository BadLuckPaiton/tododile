extends Area2D

@export var speed:float = 500;
var bullet_direction;

func _ready() -> void:
	var timer = get_node("Timer");
	timer.start();
	pass;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= bullet_direction * speed * delta;


func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.
