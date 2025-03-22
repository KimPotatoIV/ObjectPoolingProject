extends Node2D

##################################################
const ENEMY_SCENE: PackedScene = preload("res://scenes/enemy/enemy.tscn")

var spawn_timer_node: Timer

##################################################
func _ready() -> void:
	spawn_timer_node = $SpawnTimer
	spawn_timer_node.wait_time = 0.005
	spawn_timer_node.one_shot = true
	spawn_timer_node.connect("timeout", Callable(self, "_on_spawn_timer_timeout"))

##################################################
func _process(delta: float) -> void:
	if GM.get_is_spawn():
	# 인스턴스 생성을 하는 중이면
		if spawn_timer_node.is_stopped():
			spawn_timer_node.start()
			# 타이머 시작

##################################################
func _on_spawn_timer_timeout() -> void:
	spawn_enemy()
	spawn_timer_node.start()

##################################################
func spawn_enemy() -> void:
	if GM.get_pooling_mode():
	# 오브젝트 풀링 모드일 때
		if SPM.get_enemy_pool().is_empty():
		# 오브젝트 풀이 비어있으면
			fill_enemy_pool(10)
			# 오브젝트 10개 채움
		var enemy: Node2D = SPM.pop_front_enemy_pool()
		# 오브젝트 풀에서 하나 꺼내서
		enemy.global_position = get_spawn_position()
		enemy.set_is_used(true)
		# 각 설정
	else:
	# 오브젝트 풀링 모드가 아닐 때
		var enemy_instance = ENEMY_SCENE.instantiate()
		enemy_instance.global_position = get_spawn_position()
		enemy_instance.set_is_used(true)
		add_child(enemy_instance)
		# 인스턴스화

##################################################
func fill_enemy_pool(count_value: int) -> void:
	for i in range(count_value):
	# 설정값만큼
		var enemy_instance: Node2D = ENEMY_SCENE.instantiate()
		enemy_instance.global_position = get_spawn_position()
		SPM.append_enemy_pool(enemy_instance)
		add_child(enemy_instance)
		# 인스턴스화

##################################################
func get_spawn_position() -> Vector2:
	var spawn_position: Array = [\
	Vector2(randf_range(0.0, 1010.0), -50.0), \
	Vector2(randf_range(0.0, 1010.0), 1130.0), \
	Vector2(-50, randf_range(0.0, 1080.0)), \
	Vector2(1010.0, randf_range(0.0, 1080.0))]
	spawn_position.shuffle()
	# 화면 네 방향 밖으로 좌표를 임의로 설정 후 섞음
	
	var return_value = spawn_position.front()
	return return_value
	# 임의로 섞은 좌표 중 하나를 받아 반환
