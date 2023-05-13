extends PlayingFieldTilemapDetail

class_name PlayingFieldTilemap

const CELL_WALL = 0
const CELL_LEVER_ON  = 16
const CELL_LEVER_OFF  = 17
const CELL_DOOR   = 7
const CELL_ARROW_RIGHT = 11
const CELL_ARROW_UP = 12
const CELL_ARROW_DOWN = 13
const CELL_ARROW_LEFT = 14
const CELL_BUTTON_OFF = 9
const CELL_BUTTON_ON = 10

func is_wall(_cell:int)->bool:
	return _cell == CELL_WALL

func is_door(_cell:int)->bool:
	return _cell == CELL_DOOR
