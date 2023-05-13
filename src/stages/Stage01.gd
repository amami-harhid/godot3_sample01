extends PlayingFieldTilemap

# Gameノード
onready var game:Node2D = get_parent()
const Player_Scene_Path = "res://resources/Players/Player%s.tscn" 
const Enemy_Scene_Path = "res://resources/Enemies/Enemy%s.tscn" 
const GameName := "Game"

func _ready():
	_load_game()
	_load_enemy()

func _load_game():
	var _name:String = game.name
	var _no:String = _name.replace(GameName,"")
	var _scene:PackedScene = load(Player_Scene_Path%_no)
	var _obj:Node2D = _scene.instance()
	add_child(_obj)

func _load_enemy():
	var _name:String = game.name
	var _no:String = _name.replace(GameName,"")
	var _scene:PackedScene = load(Enemy_Scene_Path%_no)
	if _scene:
		var _obj:Node2D = _scene.instance()
		add_child(_obj)
	
