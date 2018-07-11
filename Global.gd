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
	#remove_child(map);
	
	get_tree().get_root().get_child(1).queue_free();
	#get_parent().remove_child(get_node("Node2D"));
	print(levelName);
	var map=load(levelName);
	print(map)
	var node=map.instance();
	node.name="Node2D";
	get_tree().get_root().add_child(node);
	pass;
	
	
func CharacterDie():
	get_tree().reload_current_scene();
	pass;