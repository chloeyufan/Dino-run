extends ParallaxBackground

export (float) var scorlling_speed = 50


func _process(delta):
	scroll_offset.x -= scorlling_speed * delta


func _on_Dino_death():
	scorlling_speed = 0


func _on_CanvasLayer_restart():
	scorlling_speed = 50
