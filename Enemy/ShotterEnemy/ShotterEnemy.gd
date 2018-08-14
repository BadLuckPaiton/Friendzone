extends "res://Enemy/BasicEnemyAI.gd";

onready var Bullet = preload("res://Enemy/Bullet_Enemy.tscn");

func Attack():
	var nodeInstance = Bullet.instance();
	nodeInstance._set_direction(player.transform.origin,transform.origin);
	var newPos = Vector2(position.x ,position.y) 
	nodeInstance.position= newPos;
	get_parent().add_child(nodeInstance)
	isAttacking=true;
	$Timer.start();
	pass;

func _on_Vision_body_entered(body):
	if body.is_in_group("Player"):
		isPlayerOnSight=true;
		player=body;
		canAttackPlayer=true;
	pass # replace with function body


func _on_Vision_body_exited(body):
	player=null;
	isPlayerOnSight=false;
	canAttackPlayer=false;
	pass # replace with function body