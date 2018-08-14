extends KinematicBody2D

var MOTION_SPEED = 60;

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
	xMinRange=position.x-150;
	xMaxRange=position.x+150;
	yMinRange=position.y-150;
	yMaxRange=position.y+150;
	add_to_group("Enemy")
	randomize();
	pass
	
func _process(delta):
	#print(is_in_group("Enemy"));
	var montion=Vector2();
	
	if isPlayerOnSight:
		if canAttackPlayer:
			if !isAttacking:
				$Timer.start();
				isAttacking=true;
				if player:
					Attack();
		else: 
			montion=_get_movement(player.position);
	else:
		
		var newPosition=is_in_radio(position.x,position.y,nextPosition.x,nextPosition.y,5);
		
		if newPosition:
			_generateNewPosition();

		montion=_get_movement(nextPosition);
		
		if currentAnimation!=nextAnimation:
			var r=5;
			#$AnimationPlayer.play(nextAnimation);
		
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
	pass # replace with function body


func _on_Vision_body_exited(body):
	player=null;
	isPlayerOnSight=false;
	pass # replace with function body

func _on_timer_timeout():
	isAttacking=false;
