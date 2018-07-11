extends KinematicBody2D

export var MOTION_SPEED = 60;

var live=100;
var isPlayerOnSight;
var canAttackPlayer;
var player;
var playerAttack;
var isAttacking;
var nextPosition=Vector2();
var currentAnimation="";
var nextAnimation="Down";

var xMinRange=0;
var xMaxRange=0;
var yMinRange=0;
var yMaxRange=0;


func _ready():
	isPlayerOnSight=false;
	$Timer.connect("timeout",self,"_on_timer_timeout")
	nextPosition=position;
	$AnimationPlayer.play(nextAnimation);
	print("start");
	print(position);
	xMinRange=position.x-150;
	xMaxRange=position.x+150;
	yMinRange=position.y-150;
	yMaxRange=position.y+150;
	randomize();
	pass

func _process(delta):
	var montion=Vector2();
	
	if isPlayerOnSight:
		if canAttackPlayer:
			if !isAttacking:
				$Timer.start();
				isAttacking=true;
				if playerAttack:
					playerAttack.damage(50);
		else: 
			montion=_get_movement(player.position);
	else:
		
		var newPosition=is_in_radio(position.x,position.y,nextPosition.x,nextPosition.y,5);
		
		if newPosition:
			_generateNewPosition();

		montion=_get_movement(nextPosition);
		
		if currentAnimation!=nextAnimation:
			$AnimationPlayer.play(nextAnimation);
		
	montion = montion * MOTION_SPEED *delta;
	
	move_and_collide(montion);
	pass

func _generateNewPosition():
	var x=0;
	var y=0;
	
	x=range(xMinRange,xMaxRange)[randi()%range(xMinRange,xMaxRange).size()]
	y=range(yMinRange,xMaxRange)[randi()%range(yMinRange,yMaxRange).size()]
		
	nextPosition.x=x;
	nextPosition.y=y;
	
	pass;

func is_in_radio(x,y,center_x,center_y,radio):
	var dx=abs(x-center_x);
	var dy=abs(y-center_y);
	var analize=false;
	
	if dx+dy<=radio:
		analize=true;
	if dx > radio:
		analize=false;
	if dy > radio:
		analize=false;
	if (dx*dx)+(dy*dy)<=radio*radio:
		analize=true;
	else:
		analize=false;
		
	return analize;
	pass;

func _get_movement(positionToMove):
	var montion=Vector2();
	#print(positionToMove);
	if (int(round(position.y))) > positionToMove.y:
		montion=montion+Vector2(0,-1);
		nextAnimation="Up";
	elif (int(round(position.y))) < positionToMove.y: 
		montion=montion+ Vector2(0,1);
		nextAnimation="Down";
	if (int(round(position.x))) > positionToMove.x:
		montion=montion+Vector2(-1,0);
		nextAnimation="Left";
	elif (int(round(position.x)))< positionToMove.x:
		montion=montion+Vector2(1,0);
		nextAnimation="Right";

	return montion;
	pass;

func _follow_player():
	var montion=Vector2();
	if position.x > player.position.x:
		montion=montion+Vector2(-1,0);
	elif position.x < player.position.x:
		montion= montion+Vector2(1,0);
	if position.y > player.position.y:
		montion=montion+Vector2(0,-1);
	elif position.y < player.position.y: 
		montion=montion+ Vector2(0,1);
	return montion;
	pass;

func _get_distance():
	var distance_x=abs(position.x-player.position.x);
	var distance_y=abs(position.y-player.position.y);
	
	var canAttack=false;
	var distance_x_toAttack=0;
	var distance_y_toAttack=0;
	
	if nextAnimation=="Left":
		distance_x_toAttack=-100;
	if nextAnimation=="Right":
		distance_x_toAttack=100;
	if nextAnimation=="Up":
		distance_y_toAttack=-100;
	if nextAnimation=="Down":
		distance_y_toAttack=100;
		
		
	if (distance_x)<distance_x_toAttack: 
		canAttack=true;
	return canAttack;
	pass;

func deal_damage(damage):
	print(live);
	live=live-damage
	if live <= 0: 
		queue_free()
	pass;

func _on_Vision_body_entered(body):
	if body.is_in_group("Player"):
		isPlayerOnSight=true;
		player=body;
		print("Ya te mire");
	pass # replace with function body


func _on_Vision_body_exited(body):
	player=null;
	isPlayerOnSight=false;
	pass # replace with function body

func _on_timer_timeout():
	isAttacking=false;

func _on_Weapon_body_entered(body):
	if body.is_in_group("Player"):
		canAttackPlayer=true;
		playerAttack=body;
		print("Ya te mire");
	pass # replace with function body


func _on_Weapon_body_exited(body):
	canAttackPlayer=false;
	playerAttack=null;
	pass # replace with function body
