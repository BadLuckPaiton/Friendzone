extends KinematicBody2D

var speed=Vector2(0,0);

export var MOTION_SPEED = 15000;

func _set_direction(direction):
	if direction==1:
		speed=Vector2(0,-1);
	elif direction==2:
		speed=Vector2(0,1);
	elif direction==3:
		speed=Vector2(1,0);
	elif direction == 4 : 
		speed=Vector2(-1,0);

func _process(delta):
	var montion=Vector2();
	
	montion = (speed * MOTION_SPEED *delta)*3;
	
	move_and_collide(montion);
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		print("type"+str(typeof(StaticBody2D)));

		body.deal_damage(15);
		var knokdir=body.transform.origin-transform.origin;
		var lol=knokdir*20*1.5;
		body.move_and_slide(lol,Vector2(0,0));
		
		
	if !body.is_in_group("Player"):
		queue_free();
	pass # replace with function body
