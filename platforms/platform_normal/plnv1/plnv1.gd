extends Node3D

#Platform V1
@onready var plnv1_l1 = $plnv1/l1
@onready var plnv1_l2 = $plnv1/l2

var light_counter = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	
	#Platform V1
	var light_on1 = round(randi_range(7,17))
	var light_on2 = round(randi_range(7,17))
	
	
	if light_counter%light_on1 == 0:
		plnv1_l1.visible = true
		light_counter += light_on1
		
	if light_counter%light_on1 != 0:
		plnv1_l1.visible = false
		light_counter += light_on1
		
	if light_counter%light_on2 == 0:
		plnv1_l2.visible = true
		light_counter += light_on2
		
	if light_counter%light_on2 != 0:
		plnv1_l2.visible = false
		light_counter += light_on2
