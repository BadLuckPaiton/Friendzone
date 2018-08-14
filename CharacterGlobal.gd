extends Node

onready var MainCharacter = preload("res://Character/MainCharacter/MainCharacter.tscn");
onready var ShotterCharacter = load("res://Character/ShotterCharacter/ShotterCharacter.tscn");

var health=100;
var energy=100;

var key=0;

var currenChar;

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	UpdateCharacter();
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	UpdateCharacter();
#	pass

func UpdateCharacter():
	currenChar=get_tree().get_root().get_child(2).get_node("Char");
	pass;
	
func ChangeCharacter(characterId,position):
	
	if characterId==1:
		var character= MainCharacter.instance();
		character.position = position;
		if currenChar!= null:
			currenChar.queue_free();
		currenChar=character;
		get_tree().get_root().get_child(2).add_child(character);
	elif characterId==2:
		var character= ShotterCharacter.instance();
		character.position = position;
		if currenChar!= null:
			currenChar.queue_free();
		currenChar=character;
		get_tree().get_root().get_child(2).add_child(character);
	
	pass;
	
func AddKey():
	key=key+1;
	pass;
	
func SubtrackKey():
	key=key-1;
	pass;
	
func CanOpenDoor():
	print(key)
	var _canOpenDoor=false;
	if key>0:
		SubtrackKey();
		_canOpenDoor=true;
	else: 
		_canOpenDoor=false;
	print(_canOpenDoor);
	return _canOpenDoor;
	pass;