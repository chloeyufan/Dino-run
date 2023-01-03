extends Area2D

export var velocity = Vector2()
export var spriteSize = int()
signal ArmorDoThing

# Called when the node enters the scene tree for the first time.


#yeet the object back to screen
func yeet_back():
	#print("postion now is (750,280)")
	position.x = 750
	position.y = 315


# Called every frame. 'delta' is the elapsed time since the previous frame.

	


func _on_ArmorUp_body_entered(body: KinematicBody2D):
	emit_signal("ArmorDoThing")
	queue_free()
	


func _on_main_Armor():
	yeet_back()
