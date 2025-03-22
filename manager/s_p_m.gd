extends Node

##################################################
var enemy_pool: Array = []

##################################################
func get_enemy_pool() -> Array:
	return enemy_pool

##################################################
func append_enemy_pool(instance_value: Node2D) -> void:
	enemy_pool.append(instance_value)

##################################################
func pop_front_enemy_pool() -> Node2D:
	return enemy_pool.pop_front()
