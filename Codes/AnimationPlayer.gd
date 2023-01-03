extends AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	# upon loading into the game, platform plays scrolling animation
	self.play("Scroll")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
