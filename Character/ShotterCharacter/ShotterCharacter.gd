extends KinematicBody2D
onready var Bullet = preload("res://Character/ShotterCharacter/Bullet/Bullet.tscn");
onready var Character = preload("res://Character/MainCharacter/MainCharacter.tscn");
export var MOTION_SPEED = 140;

var targets_in_range = [];

var isAttacking=false;

var currentAnimation="";

var direction=0;

var key = 0;

var _canChangeCharacter=false;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$Timer.connect("timeout",self,"_on_timer_timeout")
	_canChangeCharacter=false;
	$CharacterTimer.connect("timeout",self,"_on_Character_timer_timeout")
	$CharacterTimer.start();
	pass

func _process(delta):
	
	var montion=Vector2();
	var anim="";
	var degreesWeapon=0;
	
	if(Input.is_action_pressed("ui_up")):
		montion+=Vector2(0,-1);
		degreesWeapon=0;
		#rotationRayNode=179;
		#characterDirection=enumDirection.Direction.Up;
		anim="Up";
		direction=1;
		
	if(Input.is_action_pressed("ui_down")):
		montion+=Vector2(0,1);
		degreesWeapon=179;
		#rotationRayNode=0;
		#characterDirection=enumDirection.Direction.Down;
		anim="Down";
		direction=2;
	if(Input.is_action_pressed("ui_right")):
		montion+=Vector2(1,0);
		degreesWeapon=90;
		#rotationRayNode=-90;
		#characterDirection=enumDirection.Direction.Right;
		anim="Right";
		direction=3;
	if(Input.is_action_pressed("ui_left")):
		montion+=Vector2(-1,0);
		degreesWeapon=270;
		#rotationRayNode=90;
		#characterDirection=enumDirection.Direction.Left;
		anim="Left";
		direction=4;
	if(Input.is_action_pressed("ui_next")) and _canChangeCharacter:
		print("Next");
		var character= Character.instance();
		character.position = position;
		get_parent().add_child(character);
		queue_free();
		
	if $RayCast2D.is_colliding():
		print("true");
		if $RayCast2D.get_collider().is_in_group("MoveItem"):
			print(direction);
			$RayCast2D.get_collider().move_object(direction,delta);
			
	if Input.is_action_pressed("ui_attack") && !isAttacking:
		var nodeInstance = Bullet.instance();
		nodeInstance._set_direction(direction);
		var newPos = Vector2(position.x ,position.y) 
		
		nodeInstance.position= newPos;
		
		get_parent().add_child(nodeInstance)
		isAttacking=true;
		$Timer.start();
	
	montion = montion * MOTION_SPEED *delta;
	
	if currentAnimation != anim:
		$AnimationPlayer.play(anim);
	move_and_collide(montion)
	
	$Camera.align();
	
	pass

func _on_timer_timeout():
	isAttacking=false;



func _on_Body_body_entered(body):
	if body.is_in_group("Key"):
		print("Key!!!")
		key=key+1;
		body.queue_free();
	if body.is_in_group("Health"):
		print("Health");
		CharacterGlobal.health=CharacterGlobal.health+10;
		body.queue_free();
	pass # replace with function body

func can_enter():
	if key>0:
		return true;
	else: 
		return false; 
	pass;
	
func damage(damage):
	CharacterGlobal.health=CharacterGlobal.health-damage;
	pass;
	
func _on_Character_timer_timeout():
	_canChangeCharacter=true;
	pass;