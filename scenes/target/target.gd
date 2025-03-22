extends Area2D

##################################################
func _ready() -> void:
	add_to_group("Target")

##################################################
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left") or \
	Input.is_action_just_pressed("ui_right"):
		if GM.get_pooling_mode():
			GM.set_pooling_mode(false)
		else:
			GM.set_pooling_mode(true)
	# 좌우 키를 누르면 오브젝트 풀링 모드를 바꿈
	
	if Input.is_action_just_pressed("ui_accept"):
		if not GM.get_is_spawn():
			GM.set_is_spawn(true)
	# 스페이스 키를 누르면 적 생성 시작
