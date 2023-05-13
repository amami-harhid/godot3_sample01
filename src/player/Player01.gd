extends PlayerSprite

class_name Player01

const First_Position = Vector2(14,8)

func _ready():
	_first_position(First_Position)
	_animation_start()

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

func _is_trick_cell(_cell:int)->bool:
	return _cell == tilemap.CELL_LEVER_OFF

const Door_Pos := Vector2(1,1)
func _trick(_pos:Vector2):
	tilemap.set_cell(_pos.x, _pos.y,tilemap.CELL_LEVER_ON)
	tilemap.set_cell(Door_Pos.x,Door_Pos.y,tilemap.CELL_DOOR)
