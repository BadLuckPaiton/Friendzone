extends "res://Character/Character.gd"; 
onready var Bullet = preload("res://Character/ShotterCharacter/Bullet/Bullet.tscn");

func _ready():
	_characterId=1;
	pass
func Attack():
	var nodeInstance = Bullet.instance();
	nodeInstance._set_direction(direction);
	var newPos = Vector2(position.x ,position.y) 
	nodeInstance.position= newPos;
	get_parent().add_child(nodeInstance)
	isAttacking=true;
	$Timer.start();
	pass;