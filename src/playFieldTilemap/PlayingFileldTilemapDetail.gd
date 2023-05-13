extends TileMap

class_name PlayingFieldTilemapDetail

const Cell_X = 64
const Cell_Y = 64



func get_cell_half_size()->Vector2:
	return Vector2(floor(Cell_X/2),floor(Cell_Y/2))

func local_to_map(_local_pos:Vector2)->Vector2:
	var _map_pos = _local_pos / Vector2(Cell_X,Cell_Y)
	return Vector2(floor(_map_pos.x), floor(_map_pos.y))

func map_to_local(_map_pos:Vector2)->Vector2:
	var _local_pos = _map_pos * Vector2(Cell_X,Cell_Y)
	return _local_pos
	
