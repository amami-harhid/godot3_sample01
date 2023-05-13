extends PlayerCommon

class_name PlayerSprite

#-------------------------------------
# Animation
#-------------------------------------
onready var sprite:Sprite = $Body/Sprite

func _change_frame_coords_y(_dir:Vector2):
	if _dir == Dir_Left:
		#print("左へ")
		sprite.frame_coords.y = 0
	elif _dir == Dir_Up:
		#print("上へ")
		sprite.frame_coords.y = 1
	elif _dir == Dir_Right:
		#print("右へ")
		sprite.frame_coords.y = 2
	elif _dir == Dir_Down:
		#print("下へ")
		sprite.frame_coords.y = 3

func _change_frame_coords_x():
	if sprite.frame_coords.x == sprite.hframes -1:
		sprite.frame_coords.x = 0
	else:
		sprite.frame_coords.x += 1
