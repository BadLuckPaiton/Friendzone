extends KinematicBody2D

export var MOTION_SPEED = 140;

func _ready():
	
	pass

func _process(delta):
	
	pass

func move_object(direction,delta):
	
	var montion=Vector2(0,0);
	
	if direction==1: 
		montion+=Vector2(0,-1);
	elif direction==2:
		montion+=Vector2(0,1);
	elif direction==3:
		montion+=Vector2(1,0);
	elif direction==4:
		montion+=Vector2(-1,0);
	
	montion = montion * MOTION_SPEED *delta
	
	move_and_collide(montion)
	pass;