extends KinematicBody2D

var speed=Vector2(0,0);

export var MOTION_SPEED = 15000;

func _ready(direction):

	pass

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
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var montion=Vector2();
	
	montion = (speed * MOTION_SPEED *delta)*3;
	
	move_and_collide(montion);
	pass


func _on_Area2D_body_entered(body):
	print(body.is_in_group("Enemy"));
	if body.is_in_group("Enemy"):
		body.deal_damage(50);
	if !body.is_in_group("Player"):
		queue_free();
	pass # replace with function body
