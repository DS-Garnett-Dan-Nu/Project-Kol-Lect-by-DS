extends Node3D

#Load the mob senes
var ehd_v1 = preload("res://mobs/ehd/ehd_scenes/ehd_scene.tscn")

@onready var anit1 = $"../AniT1"
@onready var door_timer = $"Timer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


##Mob Spawn Interval, controlled by Timer
#func _on_timer_timeout():
#	anit1.play("close_door")



#func _on_ani_t_1_animation_finished(open_door):
#	var e = ehd_v1.instantiate()
#	add_child(e)
#	door_timer.start()
	
