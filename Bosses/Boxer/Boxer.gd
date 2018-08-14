extends KinematicBody2D

var player;

var isAttaking;

func _ready():
	add_to_group("Enemy");
	player=get_tree().get_nodes_in_group("Player").pop_front();
	print(player);
	isAttaking=true;
	pass

func _process(delta):
	if isAttaking:
		
		isAttaking=false;
		match 1:
			1:
				Combo();
				#print(player.global_position);
				
				#$Right.global_position=Vector2(player.global_position.x,player.global_position.y+200);
		$Timer.start();
	else:
		pass
		#$Right.move_and_slide(Vector2(0,-200));
	pass

func Combo():
	print("Combo");
	$Right.global_position=Vector2(player.global_position.x,player.global_position.y-200);
	
	$Timer2.start()
	yield($Timer2, "timeout")
	print("Combo 1");
	$Right.move_and_slide(Vector2(0,+5000));
	$Timer2.start()
	yield($Timer2, "timeout")
	print("Combo 2");
	pass;

func _on_Timer_timeout():
	#isAttaking=true;
	pass # replace with function body


func _on_Right_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(1);
		var knokdir=global_transform.origin-body.global_transform.origin;
		var lol=knokdir*20*1.5;
		body.move_and_slide(lol,Vector2(0,0));
	pass # replace with function body
