extends "res://Character/Character.gd"

var targets_in_range = [];

func _ready():
	$Weapon.rotation=180;
	_characterId=2;
	pass



func Attack():
	for enemy in targets_in_range:
		if enemy.is_in_group("Enemy"):
			enemy.deal_damage(10);
			var knokdir=enemy.transform.origin-transform.origin;
			var lol=knokdir*20*1.5;
			enemy.move_and_slide(lol,Vector2(0,0));
		if enemy.is_in_group("ControlSwitch"):
			enemy.Activate();
	CharacterGlobal.energy=CharacterGlobal.energy-10;
	isAttacking=true;
	$Timer.start();
	pass;

func _on_Weapon_body_entered(body):
	print(body);
	targets_in_range.push_back(body);
	pass 
	

func _on_Weapon_body_exited(body):
	for n in range(targets_in_range.size()):
		if(targets_in_range[n] == body):
			targets_in_range.remove(n)
	pass 
	


