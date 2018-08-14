extends Sprite
onready var Bullet = preload("res://Character/ShotterCharacter/Bullet/Bullet.tscn");
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	get_parent().set_offset(get_parent().get_offset()+(50*delta));
	pass
