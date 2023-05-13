extends PlayerRigidSprite

class_name Player04

const First_Position = Vector2(1,5)

func _ready():
	body.gravity_scale = 10
	body.contact_monitor = true
	body.contacts_reported = 1
	body.mode = body.MODE_CHARACTER
	_first_position(First_Position)
	_animation_start()

func _get_jump_impulse():
	return Vector2(0,-800)
func _get_slide_impulse_right():
	return Vector2(500,-200)
func _get_slide_impulse_left():
	return Vector2(-500,-200)

#func _process(delta):
#	print("player.position=",player.position)

#func _physics_process(delta):
#	print("player.position=",player.position)
#	print("player.transform=",player.transform)

func _input(event:InputEvent):
	if event is InputEventScreenTouch:
		_touch_check(event)
	elif event is InputEventKey:
		_key_check(event)

func _animation_start():
	var _timer := Timer.new()
	_timer.one_shot = false
	_timer.wait_time = 0.2
	_timer.connect("timeout",self,"_change_frame_coords_x")
	add_child(_timer)
	_timer.start()

func _escapable_cell(_dir:Vector2)->bool:
	var _map_pos = _local_to_map(position)
	var _cell = tilemap.get_cell(_map_pos.x, _map_pos.y)
	if _cell == tilemap.CELL_ARROW_RIGHT:
		return _dir == Dir_Right
	elif _cell == tilemap.CELL_ARROW_UP:
		return _dir == Dir_Up
	elif _cell == tilemap.CELL_ARROW_DOWN:
		return _dir == Dir_Down
	elif _cell == tilemap.CELL_ARROW_LEFT:
		return _dir == Dir_Left
	return true

var _lever := false
var _button := false
func _is_trick_cell(_cell:int)->bool:
	if _cell == tilemap.CELL_LEVER_OFF:
		_lever = true
		return true
	if _cell == tilemap.CELL_BUTTON_OFF:
		_button = true
		return true

	return false
	
func _trick(_pos:Vector2):
	if _lever:
		tilemap.set_cell(_pos.x, _pos.y,tilemap.CELL_LEVER_ON)
		tilemap.set_cell(4,6,tilemap.CELL_BUTTON_OFF)
	if _button:
		tilemap.set_cell(_pos.x, _pos.y,tilemap.CELL_BUTTON_ON)
		tilemap.set_cell(1,1,tilemap.CELL_DOOR)




func _on_Body_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	_touch_wall = true


func _on_Body_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	_touch_wall = false
