extends Node

signal more_jumps
signal Armor

export var upgrade_score = 1000
var armor_score = 2000

const scene = preload("res://scenes/Platforms.tscn")
const scene1 = preload("res://scenes/Time_Police.tscn")
const scene2 = preload("res://scenes/Aerial_Enemies.tscn")
const scene3 = preload("res://scenes/ArmorUp.tscn")

var i = 8
var score = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#check how many score player had
	if score == upgrade_score:
		emit_signal("more_jumps")
	if score == armor_score:
		emit_signal("Armor")


func _on_Platform_Timer_timeout():
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("PlatformPath/PlatformPathFollow");
	mob_spawn_location.offset = randi()
	
	# Create a Mob instance and add it to the scene.
	var plat = scene.instance()
	add_child(plat)
	
	plat.position = mob_spawn_location.position
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	plat.position = mob_spawn_location.position
	
	
	


func _on_Mob_Timer_timeout():
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobPathFollow");
	mob_spawn_location.offset = randi()
	
	var fly_spawn_location = get_node("FlyingPath/FlyingPathFollow");
	fly_spawn_location.offset = randi()
	
	# Create a Mob instance and add it to the scene.
	var mob = scene1.instance()
	add_child(mob)
	var flying = scene2.instance()
	add_child(flying)
	
	mob.position = mob_spawn_location.position
	flying.position = fly_spawn_location.position
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	var direction1 = fly_spawn_location.rotation + PI / 2
	# Set the mob's position to a random location.
	
	flying.position = fly_spawn_location.position
	mob.position = mob_spawn_location.position


func _on_CanvasLayer_timer_Start():
	$"Platform Timer".start()
	$"Mob Timer".start()
	$"ScoreTimer".start()
	$"DifficultyTimer".start()
	$DifficultyTimer.start()
	score = 0


func _on_ScoreTimer_timeout():
	score += 100
	$CanvasLayer.update_score(score)


func _on_CanvasLayer_timer_stop():
	$"Platform Timer".stop()
	$"Mob Timer".stop()
	$"ScoreTimer".stop()
	$"DifficultyTimer".stop()
	


func _on_DifficultyTimer_timeout():
	i -= 1
	if i != 0:
		$"Mob Timer".set_wait_time(i)
	elif i == 0:
		$"Mob Timer".set_wait_time(8)



