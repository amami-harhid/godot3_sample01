extends Node2D

class_name PlayerRigidCommon
onready var main:Main = get_tree().root.get_node('Main')
onready var tilemap:PlayingFieldTilemap = get_parent()
onready var body:RigidBody2D = $Body
onready var collision:CollisionShape2D = $Body/CollisionShape2D
var player = self

const Dir_Right := Vector2(1,0)
const Dir_Left := Vector2(-1,0)
const Dir_Down := Vector2(0,1)
const Dir_Up := Vector2(0,-1)

var _sounds:Sounds = Sounds.new()

func _init():
	_sounds.load_sounds(self)
	_sounds.play_MusMus_BGM_090()

func _first_position(_map_pos:Vector2):
	var _local_pos:Vector2 = _map_to_local(_map_pos)
	body.position = _local_pos + Vector2(tilemap.Cell_X, tilemap.Cell_Y) / 2

func _touch_check(_event:InputEvent):
		# MOUSE TOUCH
		if _event.is_pressed():
			var _mouse_pos = _event.position
			var _pos = _mouse_pos  - body.position
			var _abs_pos = Vector2(abs(_pos.x),abs(_pos.y))
			if _abs_pos.x > _abs_pos.y :
				if _pos.x > 0:
					# 右へ
					_move( Dir_Right )
				else:
					_move( Dir_Left )
			else:
				if _pos.y < 0:
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
	if Input.is_action_just_pressed("ui_right"):
		_move( Dir_Right )
	if Input.is_action_just_pressed("ui_left"):
		_move( Dir_Left )
	if Input.is_action_just_pressed("ui_up"):
		_move( Dir_Up )

func _move(_dir:Vector2):
	_change_frame_coords_y(_dir)

	if _dir == Dir_Up:
		if _is_touch_wall():
			body.apply_central_impulse(Vector2(0,-400))
	if _dir == Dir_Right:
			body.apply_central_impulse(Vector2(100,-100))
	if _dir == Dir_Left:
			body.apply_central_impulse(Vector2(-100,-100))
	
	if _is_entered_door():
		_sounds.stop_MusMus_BGM_090()
		main.load_next_stage()
		
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

var _touch_wall = false
func _is_touch_wall()->bool:
	return _touch_wall
	
func _is_entered_door()->bool:
	var _map_pos = tilemap.local_to_map(body.position)
	var _cell = tilemap.get_cell(_map_pos.x, _map_pos.y)
	
	return _cell == tilemap.CELL_DOOR
