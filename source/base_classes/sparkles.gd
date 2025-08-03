class_name BuffSparkles
extends CPUParticles2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = load("res://assets/sprites/sparkle.png")
	amount = 12
	one_shot = true
	explosiveness = 0.5
	spread = 180
	gravity.y = -450
	initial_velocity_min = 50
	initial_velocity_max = 50
	scale = Vector2(3, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_finished() -> void:
	queue_free()
