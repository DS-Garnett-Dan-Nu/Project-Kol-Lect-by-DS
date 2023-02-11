extends Spatial


# Declare member variables here. Examples:
var x = true
var y = 0.1
# var b = "text"
onready var c = $s

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if x == true:
		c.translation.y -= y
		if c.translation.y < -1.5:
			x = false
			y = rand_range(0.01,0.02)
	if x == false:
		c.translation.y += y
		if c.translation.y > 1.5:
			x = true
			y = rand_range(0.01,0.02)
	
