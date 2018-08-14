extends StaticBody2D

export var _isActivate=false;

func _ready():
	ChangeState();
	pass

func ChangeState():
	print("Change State"+str(_isActivate));
	if _isActivate:
		$CollisionShape2D.disabled=true;
	else:
		$CollisionShape2D.disabled=false;
	_isActivate=!_isActivate;
	pass;