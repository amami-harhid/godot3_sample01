extends Node

class_name Commons

const StagePath = "res://resources/Stages/Stage%02d.tscn"
func loadStage(_level:int=1)->Node2D:
	var _stage:PackedScene = load(StagePath%_level)
	var _obj:Node2D = _stage.instance()
	
	return _obj
