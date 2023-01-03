extends Sprite

signal Upgrade_jump

#export var start_pos = (1200,280)
#export var end_pos = (750,280)

#yeet the object away from camera
func yeet_away():
	#print("postion now is (1200,280)")
	position.x =1200
	position.y = 280
	
#yeet the object back to screen
func yeet_back():
	#print("postion now is (750,280)")
	position.x = 750

func _on_main_more_jumps():
	yeet_back()

func _on_CanvasLayer_restart():
	yeet_away()


func _on_Player_detect_body_exited(body):
	if "Dino" in body.name:
		emit_signal("Upgrade_jump")
		yeet_away()
