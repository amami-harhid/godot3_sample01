extends Node2D

class_name Main

onready var mainPlayingFieldNode:Node2D = $MainPlayingFieldNode

var _commons:Commons = Commons.new()

var _stage_level := -1
const Stage_First_Level := 3
const Stage_Max_Level := 4
var _load_timer:Timer

func _ready():
	_stage_level = Stage_First_Level
	_setup_load_timer()
	_load_first_stage()

func _setup_load_timer():
	_load_timer = Timer.new()
	_load_timer.one_shot = true
	_load_timer.wait_time = 1
	add_child(_load_timer)

func _load_first_stage():
	# 最初のステージをロードして子ノードに追加(MainPlayingFieldNode)
	mainPlayingFieldNode.hide()
	_load_timer.connect("timeout",self,"_load_stage")
	_load_timer.start()

func load_next_stage():
	mainPlayingFieldNode.hide()
	_stage_level = 1 if not _stage_level < Stage_Max_Level else _stage_level + 1
	_load_timer.connect("timeout",self,"_load_stage")
	_load_timer.start()

func _load_stage():
	var _obj :Node2D = _commons.loadStage(_stage_level)
	var _children = mainPlayingFieldNode.get_children()
	for _child in _children:
		mainPlayingFieldNode.remove_child(_child)
	mainPlayingFieldNode.add_child(_obj)
	mainPlayingFieldNode.show()
