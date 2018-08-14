extends KinematicBody2D

var speed=Vector2(0,0);

export var MOTION_SPEED = 60;

func _ready(direction):

	pass

func _set_direction(positionToMove,centerPosition):
	#var knokdir=positionToMove-transform.origin;
	positionToMove.x=positionToMove.x/50;
	positionToMove.y=positionToMove.y/50;
	centerPosition.x=centerPosition.x/50;
	centerPosition.y=centerPosition.y/50;
	speed=positionToMove-centerPosition;
	pass;

func _process(delta):
	var montion=Vector2();
	
	montion = speed*2;
	#print(montion);
	move_and_slide(montion,Vector2(0,0));
	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		body.damage(1);
		var knokdir=body.transform.origin-transform.origin;
		var lol=knokdir*20*1.5;
		body.move_and_slide(lol,Vector2(0,0));
	if !body.is_in_group("Enemy"):
		queue_free();
	pass # replace with function body
