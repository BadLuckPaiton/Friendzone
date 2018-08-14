extends "res://Enemy/BasicEnemyAI.gd";

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$AnimationPlayer.play("Default")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Ball_1_body_entered(body):
	_on_Body_entered(body)
	pass # replace with function body


func _on_Ball_2_body_entered(body):
	_on_Body_entered(body)
	pass # replace with function body


func _on_Ball_3_body_entered(body):
	_on_Body_entered(body)
	pass # replace with function body


func _on_Ball_4_body_entered(body):
	_on_Body_entered(body)
	pass # replace with function body

func _on_Body_entered(body):
	if body.is_in_group("Player"):
		body.damage(10);
		var knokdir=body.transform.origin-transform.origin;
		var lol=knokdir*20*1.5;
		body.move_and_slide(lol,Vector2(0,0));
	pass;