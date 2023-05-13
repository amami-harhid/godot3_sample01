extends RigidBody2D

onready var enemyNode:Node2D = get_parent()
onready var sprite:Sprite = $Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sleeping = true
	visible = true
	mass = 10
	gravity_scale = 0.2
	_timer()
	pass # Replace with function body.
var _timer:Timer
func _timer():
	_timer = Timer.new()
	_timer.one_shot = false
	_timer.wait_time = 0.2
	_timer.connect("timeout",self,"_animation")
	add_child(_timer)
	_timer.start()
	

func _animation():
	if not sprite.frame_coords.x+1 < sprite.hframes:
		sprite.frame_coords.x = 0
	else:
		sprite.frame_coords.x += 1
	self.rotation_degrees += 30*PI
	

const Target_Name := 'EnemyBody'
func _on_Body_body_entered(body):
	if body.name == 'Body':
		self._timer.stop()
		self.remove_child(_timer)
		self.sleeping = true
		self.hide()
		get_tree().queue_delete(self)
	# body.name => @EnemyBody@00
	if body.name.substr(1,Target_Name.length()) == Target_Name:
		enemyNode.atack()
	pass
