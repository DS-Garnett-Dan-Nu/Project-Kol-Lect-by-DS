extends Node3D





#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$invi_wall/a.set_deferred("disabled",true)
	$invi_wall/b.set_deferred("disabled",true)
	$blockades.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#time to let the player go...
	if AutoLoad.final_boss == false:
		$invi_wall/a.set_deferred("disabled",true)
		$invi_wall/b.set_deferred("disabled",true)
		$blockades.hide()
		$bossmusic.stop()
		


func _on_playerdector_area_entered(area):
	AutoLoad.final_boss = true
	$blockades.show()
	if !$bossmusic.playing:
		$bossmusic.play()
		
		#Create Blockades
		$blockades/ani.play("CINEMA_4D_Main")
		
		#add explosion
		var ex = basic_explosion.instantiate()
		$blockades/fires/ptb.add_child(ex)
		
		var ex1 = basic_explosion.instantiate()
		$blockades/fires/pts.add_child(ex1)
		ex1.scale = Vector3(2,2,2)
		
	
	$invi_wall/a.set_deferred("disabled",false)
	$invi_wall/b.set_deferred("disabled",false)
	
	

	


func _on_playerdector_area_exited(area):
	
	
	pass
	#AutoLoad.final_boss = false #only when the boss dies







