extends CharacterBody2D
var speed:float = 200;
var target:Vector2 = Vector2.ZERO;

var bullet_direction;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = get_viewport().get_mouse_position();
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position -= bullet_direction * speed * delta;
