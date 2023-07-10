extends Area3D
class_name flak_cannon

var dir = Vector3()
var speed = 180

@onready var hit = $hit


func _ready():
	set_as_top_level(true)
	
func _process(delta):
	position += transform.basis.x * speed * delta
	





func _on_area_entered(area):
	
	if area is platform or area is bbb or area is spnrt1:
		hit_effect()
	else:
		pass

	

func hit_effect():
	
	$a.global_position = $b.global_position
	$c.global_position = $b.global_position
	$d.global_position = $b.global_position
	$hit.global_position = $b.global_position
	
	
	$hitbox.set_deferred("disabled",true)
	$flak_main.hide()
	$Timer.start()
	hit.emitting = true
	speed = 0

func _on_timer_timeout():
	queue_free()
