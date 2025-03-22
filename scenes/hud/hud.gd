extends CanvasLayer

##################################################
var current_fps_label_node: Label
var average_fps_label_node: Label
var mode_label_node: Label
var time_label: Label

var total_fps: int = 0
var count: int = 0
var time: float = 0.0

##################################################
func _ready() -> void:
	current_fps_label_node = $CurrentFPSLabel
	average_fps_label_node = $AverageFPSLabel
	mode_label_node = $ModeLabel
	time_label = $TimerLabel
	
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	# 화면 주사율에 맞춘 VSYNC 제한 없앰

##################################################
func _process(delta: float) -> void:
	var current_fps = Engine.get_frames_per_second()
	# FPS
	total_fps += int(current_fps)
	count += 1
	
	current_fps_label_node.text = "FPS: " + str(int(current_fps))
	average_fps_label_node.text = "AVERAGE: " + str(get_average())
	
	var minutes = int(time) / 60
	var seconds = fmod(time, 60)
	time_label.text = "TIME: %02d:%02d" % [minutes, seconds]
	
	if GM.get_is_spawn():
		time += delta
	
	if GM.get_pooling_mode():
		mode_label_node.text = "POOLING\nMODE"
	else:
		mode_label_node.text = "NON-POOLING\nMODE"

##################################################
func get_average() -> int:
	if count == 0:
		return 0
	
	return total_fps / count
