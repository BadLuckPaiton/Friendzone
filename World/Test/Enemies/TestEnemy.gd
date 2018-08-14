extends "res://Enemy/BasicEnemyAI.gd";

func _on_Weapon_body_entered(body):
	if body.is_in_group("Player"):
		canAttackPlayer=true;
		playerAttack=body;
	pass # replace with function body


func _on_Weapon_body_exited(body):
	canAttackPlayer=false;
	playerAttack=null;
	pass # replace with function body

func Attack():
	player.damage(10);
	var knokdir=player.transform.origin-transform.origin;
	var lol=knokdir*20*1.5;
	player.move_and_slide(lol,Vector2(0,0));
	pass;