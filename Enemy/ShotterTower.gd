extends StaticBody2D

onready var Bullet = preload("res://Enemy/Bullet_Enemy.tscn");

var IsCharacterInRange;
var isAttacking;
var character;
func _ready():
	IsCharacterInRange=false;
	isAttacking=false;
	$Timer.connect("timeout",self,"_on_timer_timeout")
	pass

func _process(delta):
	if IsCharacterInRange and !isAttacking:
		var nodeInstance = Bullet.instance();
		nodeInstance._set_direction(character.transform.origin,transform.origin);
		var newPos = Vector2(position.x ,position.y) 
		nodeInstance.position= newPos;
		get_parent().add_child(nodeInstance)
		isAttacking=true;
		$Timer.start();
	pass

func _on_timer_timeout():
	isAttacking=false;
	pass;

func _on_body_entered(body):
	if body.is_in_group("Player"):
		IsCharacterInRange=true;
		character=body;
	pass # replace with function body

func _on_body_exited(body):
	IsCharacterInRange=false;
	body=null;
	pass # replace with function body

func deal_damage(damage):
	
	pass;