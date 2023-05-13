extends Node2D

class_name PlayerCommon
onready var main:Main = get_tree().root.get_node('Main')
onready var tilemap:PlayingFieldTilemap = get_parent()
var player = self

const Dir_Right := Vector2(1,0)
const Dir_Left := Vector2(-1,0)
const Dir_Down := Vector2(0,1)
const Dir_Up := Vector2(0,-1)

func _first_position(_map_pos:Vector2):
	var _local_pos:Vector2 = _map_to_local(_map_pos)
	self.position = _local_pos + Vector2(tilemap.Cell_X, tilemap.Cell_Y) / 2

func _touch_check(_event:InputEvent):
		# MOUSE TOUCH
		if _event.is_pressed():
			print("is_pressed()")
			var _mouse_pos = _event.position
			var _pos = _local_to_map(_mouse_pos)  - _local_to_map(player.position)
			var _abs_pos = Vector2(abs(_pos.x),abs(_pos.y))
			if _abs_pos.x > _abs_pos.y :
				if _pos.x > 0:
					# 右へ
					_move( Dir_Right )
				else:
					_move( Dir_Left )
			else:
				if _pos.y > 0:
					_move( Dir_Down )
				else:
					_move( Dir_Up )

func _local_to_map(_pos)->Vector2:
	var _map = Vector2(floor(_pos.x/tilemap.Cell_X),floor(_pos.y/tilemap.Cell_Y))
	return _map

func _map_to_local(_pos)->Vector2:
	var _local = _pos * Vector2(tilemap.Cell_X,tilemap.Cell_Y)
	return _local

func _get_cell(_pos:Vector2)->int:
	var _cell = tilemap.get_cell(_pos.x, _pos.y)
	return _cell

func _key_check(_event:InputEvent):
	# KEY PRESS
	if Input.is_action_just_pressed("ui_down"):
		_move( Dir_Down )
	if Input.is_action_just_pressed("ui_right"):
		_move( Dir_Right )
	if Input.is_action_just_pressed("ui_left"):
		_move( Dir_Left )
	if Input.is_action_just_pressed("ui_up"):
		_move( Dir_Up )

func _move(_dir:Vector2):
	_change_frame_coords_y(_dir)
	var _map_pos = _local_to_map(player.position)
	if _escapable_cell(_dir):
		var _next_pos = _map_pos+_dir
		var _next_cell = _get_cell(_next_pos)
		var _enable_walk := true
		if _next_cell > -1 :
			_audio_play()
			if tilemap.is_wall(_next_cell):
				_enable_walk = false
		if _enable_walk :
			player.position += _map_to_local(_dir)
		if tilemap.is_door(_next_cell):
			_next_stage()
		if _is_trick_cell(_next_cell):
			_trick(_next_pos)
	
func _escapable_cell(_dir:Vector2)->bool:
	return true

func _change_frame_coords_y(_dir:Vector2):
	pass

func _audio_play():
	pass

func _next_stage():
	main.load_next_stage()

func _is_trick_cell(_cell:int)->bool:
	return false
	
func _trick(_pos:Vector2):
	pass
