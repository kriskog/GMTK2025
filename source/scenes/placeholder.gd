extends Sprite2D

# circular motion angular speed
var angular_speed = PI / 6

# rotation angular speed
var rotate_speed = PI

# radius of rotation
var radius = 1000

# Time vector
var mytime = 0


func _process(delta):
	# Time marches on
	mytime += delta

	# x (left/right) and y (up/down) speed
	var xvel = -radius * sin(2 * PI * mytime / angular_speed)
	var yvel = radius * cos(2 * PI * mytime / angular_speed)

	# Velocity vector
	var vel = xvel * Vector2.RIGHT + yvel * Vector2.UP

	position += vel * delta
	rotation += rotate_speed * delta
