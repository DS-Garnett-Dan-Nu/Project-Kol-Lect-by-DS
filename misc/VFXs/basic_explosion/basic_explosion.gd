extends Node3D

@onready var VFXs = [$red,$smoke,$boom]

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in VFXs:
		i.emitting = true
	$sfx.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sfx_finished():
	queue_free()
