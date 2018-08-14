extends Node


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func ChangeScene(levelName):
	var characterId=CharacterGlobal.currenChar._characterId
	get_tree().get_root().get_child(2).queue_free();
	var map=load(levelName);
	var node=map.instance();
	node.name="Node2D";
	get_tree().get_root().add_child(node);
	var t = Timer.new()
	t.set_wait_time(0.02)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	CharacterGlobal.currenChar=null;
	CharacterGlobal.ChangeCharacter(characterId,Vector2(0,0));
	t.queue_free()
	pass;
	
	
func CharacterDie():
	get_tree().reload_current_scene();
	pass;