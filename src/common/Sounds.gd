extends Node

class_name Sounds

const MusMus_BGM_090 = "res://assets/MusMus-BGM-090.mp3"
const Hit08_1 = "res://assets/Hit08-1.mp3"

var _stream_musmus_bgm_090:AudioStreamMP3
var _stream_hit08_1:AudioStreamMP3

var _player_musmus_bgm_090:AudioStreamPlayer2D
var _player_hit08_1:AudioStreamPlayer2D


func _init():
	_player_musmus_bgm_090 = AudioStreamPlayer2D.new()
	_player_hit08_1 = AudioStreamPlayer2D.new()
	pass

func load_sounds(_node:Node2D):
	_stream_musmus_bgm_090 = load(MusMus_BGM_090)
	_player_musmus_bgm_090.stream = _stream_musmus_bgm_090
	_player_musmus_bgm_090.pitch_scale = 1.5 # 倍速
	_stream_hit08_1 = load(Hit08_1)
	_player_hit08_1.stream = _stream_hit08_1
	_node.add_child(_player_musmus_bgm_090)
	_node.add_child(_player_hit08_1)
	
func play_MusMus_BGM_090():
	_player_musmus_bgm_090.play()

func stop_MusMus_BGM_090():
	_player_musmus_bgm_090.stop()

func play_Hit08_1():
	_player_hit08_1.play()
