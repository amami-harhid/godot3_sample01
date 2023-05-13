extends PlayingFieldTilemap

# Gameノード
onready var game:Node2D = get_parent()
const Player_Scene_Path = "res://resources/Players/Player%s.tscn" 
# Called when the node enters the scene tree for the first time.
func _ready():
	var _name:String = game.name
#	print("_name=",_name)
	var _no:String = _name.replace("Game","")
#	print("_no=",_no)
	var _scene:PackedScene = load(Player_Scene_Path%_no)
	var _obj:Node2D = _scene.instance()
	add_child(_obj)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
