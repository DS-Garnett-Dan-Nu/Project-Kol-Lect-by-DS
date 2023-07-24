extends Node3D

#node
@onready var bbb = $bbb
@onready var forward = $forward
@onready var backward = $backward

#Stats
var health = 2500
@onready var sparks = [$bbb/body/fa,$bbb/body/fb,$bbb/body/fc,$bbb/body/fd]

#Movement Control
var front = false
var back = true

#controls
var control = true
var x = true
var start = false

#Mobs to spawn
var _ehd = load("res://mobs/ehd/ehd_scenes/ehd_scene.tscn")

#Rocket to Shoot
@onready var rc_ports = [$bbb/RCports/gun1,$bbb/RCports/gun2,$bbb/RCports/gun3,$bbb/RCports/gun4]
var _rc = load("res://mobs/spawners/spawnert1/spwnt_1_bullet.tscn")
var fire_rc = false
var rc_count = 0

#DFA to drop
var _dfa = load("res://mobs/dfa/dfa.tscn")

#Die control
var dead_time = false
var die_count = 0
var fall_time = false

#Explosion VFXs
@onready var basic_explosion = load("res://misc/VFXs/basic_explosion/basic_explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for i in sparks:
		i.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#play the intro
	if AutoLoad.final_boss and $start_ani.is_playing() == false and start == false:
		$start_ani.play("intro")
	
	#Fall Time!
	if fall_time:
		forward.stop()
		backward.stop()
		$bbb.global_position.y -= 0.05
		$bbb.global_position.z -= 0.025
		$bbb.rotation_degrees += Vector3(-0.025,0.025,0.025)
		if $bbb.global_position.y <= 0:
			AutoLoad.final_boss = false
	
	#initiate!
	if AutoLoad.final_boss and control and start:
		forward.start()
		$rc_interval.start()
		control = false
		$dfa_spt/d_ani.play("dfa_move")
		
		
		
	#Move Front and Back!
	if front and global_position.z < 0 and AutoLoad.final_boss:
		global_position.z += 0.15
		backward.start()
		
		
		
	if back and global_position.z > -40 and AutoLoad.final_boss:
		global_position.z -= 0.15
		forward.start()
		$rc_interval.start()
	
	#Die!
	if health <= 0:
		die()
	if health <= 2000:
		sparks[0].show()
	if  health <= 1500:
		sparks[1].show()
	if health <= 1000:
		sparks[2].show()
	if health <= 500:
		sparks[3].show()
	



func _on_forward_timeout():
	front = true
	back = false
	$m_ani.play("leftnright")
	$rc_interval.stop()
	


func _on_backward_timeout():
	front = false
	back = true
	$m_ani.pause()
	



func _on_indie_timer_timeout():
	
	#if Boss is alive
	if AutoLoad.final_boss and dead_time == false and start:
		
		#Spawn Mob
		if front:
			if bbb.position.z < -2.4:
				var m = _ehd.instantiate()
				$bbb/enemyspawnpts/r.add_child(m)
				m.scale = Vector3(0.1,0.1,0.1)
				m.global_position.z = 0
				m.rotation_degrees.y = 90
				m.reparent($Node)
			
			if bbb.position.z > 2.4:
				var m = _ehd.instantiate()
				$bbb/enemyspawnpts/l.add_child(m)
				m.scale = Vector3(0.1,0.1,0.1)
				m.global_position.z = 0
				m.rotation_degrees.y = -90
				m.reparent($Node)
		
		#Fire Rocket Missle Thing!
		if rc_count < 4 and fire_rc and back:
			
			var rc = _rc.instantiate()
			rc_ports[rc_count].add_child(rc)
			rc.player_is_far = 0.3
			rc.scale = Vector3(0.1,0.1,0.1)
			rc.reparent($Node)
			rc_count += 1
			$rc_interval.start()
			
		#Spawn DFA
		var x = round(randi_range(0,5))
		if x == 0 and back:
			var d = _dfa.instantiate()
			$dfa_spt.add_child(d)
			d.scale = Vector3(0.1,0.1,0.1)
			d.reparent($Node)
			
	elif dead_time:
		
		front = false
		back = true
		$m_ani.pause()
		
		if die_count < 4 and back:
			var b = basic_explosion.instantiate()
			sparks[die_count].add_child(b)
			die_count += 1
		else:
			fall_time = true
			
	


func _on_rc_interval_timeout():
	rc_ports.shuffle()
	fire_rc = true
	rc_count = 0
	$rc_interval.stop()
		
	
	


func _on_hurtbox_area_entered(area):
	#Define the bullet type
	if area is autocannon:
		health -= AutoLoad.fcc_auto_damage
	if area is flak_cannon:
		health -= AutoLoad.fcc_flak_damage
	if area is platform:
		die()
	if area.is_in_group("player_hit"):
		die()


func die():
	dead_time = true


func _on_start_ani_animation_finished(anim_name):
	start = true
