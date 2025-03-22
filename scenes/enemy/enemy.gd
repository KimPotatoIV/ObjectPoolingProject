extends Area2D

##################################################
const TARGET_POSITION: Vector2 = Vector2(480.0, 540.0)
# 화면 가운데 좌표
const MOVING_SPEED: float = 100.0
# 이동 속도

var sprite_node: Sprite2D
var collision_node: CollisionShape2D
var velocity: Vector2 = Vector2.ZERO
var is_used: bool = false

##################################################
func _ready() -> void:
	sprite_node = $Sprite2D
	collision_node = $CollisionShape2D
	
	connect("area_entered", Callable(self, "_on_area_entered"))
	
	add_to_group("Enemy")

##################################################
func _physics_process(delta: float) -> void:
	if is_used:
	# 이 인스턴스를 사용 중이면
		var direction = (TARGET_POSITION - global_position).normalized()
		velocity = direction * MOVING_SPEED * delta
		global_position += velocity
		# 타깃으로 이동

##################################################
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Target"):
	# 충돌체가 타깃이면
		if GM.get_pooling_mode():
		# 오브젝트 풀링 모드일 때
			set_is_used(false)
			# 인스턴스 미사용 설정
			SPM.append_enemy_pool(self)
			# 오브젝트 풀에 반환
		else:
		# 오브젝트 풀링 모드가 아닐일 때
			queue_free()
			# 인스턴스 삭제

##################################################
func set_is_used(used_value: bool) -> void:
	is_used = used_value
	
	if GM.get_pooling_mode():
	# 오브젝트 풀링 모드일 때
		if is_used:
		# 이 인스턴스를 사용 중이면
			sprite_node.visible = true
			collision_node.disabled = false
			set_physics_process(true)
			# 각 연산 켜기
		else:
		# 이 인스턴스를 사용 중이 아니면
			sprite_node.visible = false
			call_deferred("disabled_collision_node")
			set_physics_process(false)
			# 각 연산 끄기

##################################################
func disabled_collision_node() -> void:
	collision_node.disabled = true
