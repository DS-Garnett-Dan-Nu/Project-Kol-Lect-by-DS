extends Area3D
class_name ehd

#Offence
@onready var dmg_givr = $CollisionShape3D
@onready var dps_timer = $dps_timer
@onready var dps_timer2 = $dps_timer2

# Called when the node enters the scene tree for the first time.
func _ready():
	$drill_damage.hide()
	$drill_damage/ani.play("damage")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_dps_timer_timeout():
	dps_timer2.start()
	dmg_givr.set_deferred("disabled",true)


func _on_dps_timer_2_timeout():
	dps_timer.start()
	dmg_givr.set_deferred("disabled",false)





func _on_vfx_area_entered(area):
	$drill_damage.show()
	$drs.play()


func _on_vfx_area_exited(area):
	$drill_damage.hide()
	$drs.stop()
