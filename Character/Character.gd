#CharacterScripts
extends KinematicBody2D;


export var MOTION_SPEED = 140;

var isAttacking=false;

var currentAnimation="";

var direction=0;

var _canChangeCharacter=false;

var _characterId=0;

func _ready():
	$Timer.connect("timeout",self,"_on_timer_timeout");
	$CharacterTimer.connect("timeout",self,"_on_Character_timer_timeout")
	_canChangeCharacter=false;
	$CharacterTimer.start();
	pass

func _process(delta):
	
	moving(delta);
	
	InputActions(delta);
	
	pass

func moving(delta):
	var montion=Vector2();
	var anim="";
	if(Input.is_action_pressed("ui_up")):
		montion+=Vector2(0,-1);
		anim="Up";
		direction=1;
	if(Input.is_action_pressed("ui_down")):
		montion+=Vector2(0,1);
		anim="Down";
		direction=2;
	if(Input.is_action_pressed("ui_right")):
		montion+=Vector2(1,0);
		anim="Right";
		direction=3;
	if(Input.is_action_pressed("ui_left")):
		montion+=Vector2(-1,0);
		anim="Left";
		direction=4;
		
	montion = montion * MOTION_SPEED *delta;
	
	if currentAnimation != anim:
		$Animate.play(anim);
		
	move_and_collide(montion)
	
	$Camera.align();
	pass;

func InputActions(delta):
	if(Input.is_action_pressed("ui_next")) and _canChangeCharacter:
		CharacterGlobal.ChangeCharacter(_characterId,position);
		
	if Input.is_action_pressed("ui_attack") && !isAttacking:
		Attack();
		
	if $RayCast2D.is_colliding():
		if $RayCast2D.get_collider().is_in_group("MoveItem"):
			$RayCast2D.get_collider().move_object(direction,delta);
	pass;

func _on_timer_timeout():
	isAttacking=false;

func _on_Body_body_entered(body):
	if body.is_in_group("Key"):
		CharacterGlobal.AddKey();
		body.queue_free();
	if body.is_in_group("Health"):
		CharacterGlobal.health=CharacterGlobal.health+10;
		body.queue_free();
	pass # replace with function body

func damage(damage):
	CharacterGlobal.health=CharacterGlobal.health-damage;
	if CharacterGlobal.health <=0:
		Global.CharacterDie();
	
	pass;
	
func can_enter():
	return CharacterGlobal.CanOpenDoor();
	pass;

func _on_Character_timer_timeout():
	_canChangeCharacter=true;
	pass;