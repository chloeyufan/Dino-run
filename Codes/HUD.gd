extends CanvasLayer

signal restart
signal Quit
signal timer_Start
signal timer_stop

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#basically hide everything in hud
func _ready():
	$gameover.hide()
	$Replay.hide()
	$Quit.hide()
	$ScoreLabel.hide()
	$Score_label.hide()
	$Final_Score.hide()
	$Final_Score/Final_Score_Label.hide()
	$Start.show()
	$Title_text.show()
	$Tutorial.show()
	$"Power Ups Bar".hide()
	$"Power Ups Bar/Armour".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Dino_death():
	$gameover.show()
	$Replay.show()
	$Quit.show()
	$Final_Score.show()
	$Tutorial.show()
	$Final_Score/Final_Score_Label.show()
	emit_signal("timer_stop")
	final_score($ScoreLabel.text)
	$ScoreLabel.hide()
	$Score_label.hide()
	$"Power Ups Bar".hide()


func _on_Replay_pressed():
	emit_signal("restart")
	emit_signal("timer_Start")
	update_score(0)
	$gameover.hide()
	$Replay.hide()
	$Quit.hide()
	$Title_text.hide()
	$Start.hide()
	$Tutorial.hide()
	$"Power Ups Bar".show()
	$Score_label.show()
	$ScoreLabel.show()
	$Final_Score.hide()
	$Final_Score/Final_Score_Label.hide()
	$"Power Ups Bar/Jump_logo".hide()
	$"Power Ups Bar/Armour".hide()


func _on_Quit_pressed():
	emit_signal("Quit")


func _on_Start_pressed():
	$Title_text.hide()
	$Start.hide()
	$"Power Ups Bar".show()
	$"Power Ups Bar/Jump_logo".hide()
	$"Power Ups Bar/Armour".hide()
	$Score_label.show()
	$ScoreLabel.show()
	emit_signal("timer_Start")
	emit_signal("restart")
	$Tutorial.hide()

	

func update_score(score):
	$ScoreLabel.text = str(score)
	
func final_score(score):
	$Final_Score/Final_Score_Label.text = str(score)
	
	
	
func _on_ArmorUp_ArmorDoThing():
	$"Power Ups Bar/Armour".show()

func _on_JumpUpgrade_Upgrade_jump():
	$"Power Ups Bar/Jump_logo".show()


func _on_Dino_turnArmorOff():
	$"Power Ups Bar/Armour".hide()
	
