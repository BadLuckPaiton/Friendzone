extends StaticBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
func _on_Body_body_entered(body):
	if body.is_in_group("Player"):
		if body.can_enter():
			Global.ChangeScene("res://World/Test/Test_1.tscn")
		
	pass # replace with function body
