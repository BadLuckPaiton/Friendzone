extends KinematicBody2D

func _ready():
	pass

func Activate():
	print("Activate");
	var allinGroup= get_tree().get_nodes_in_group("ActivateItem");
	print(allinGroup);
	for objects in allinGroup:
		objects.ChangeState();
	pass;