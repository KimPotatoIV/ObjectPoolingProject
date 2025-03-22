extends Node

##################################################
var pooling_mode: bool = false
var is_spawn: bool = false

##################################################
func get_pooling_mode() -> bool:
	return pooling_mode

##################################################
func set_pooling_mode(mode_value: bool) -> void:
	pooling_mode = mode_value

##################################################
func get_is_spawn() -> bool:
	return is_spawn

##################################################
func set_is_spawn(spawn_value: bool) -> void:
	is_spawn = spawn_value
