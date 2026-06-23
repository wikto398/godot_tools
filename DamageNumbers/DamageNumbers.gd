class_name DamageNumbers extends Label

var damage: int
var critical_hit: bool = false
var target_node: Node2D

func _init(_damage: int, _target_node: Node2D,_critical_hit: bool = false) -> void:
	damage = _damage
	critical_hit = _critical_hit
	target_node = _target_node

func _ready() -> void:
	self.text = str(damage)
	show_damage()

func show_damage() -> void:
	_modify_parameters()
	_create_tween()

func _modify_parameters() -> void:
	text = str(damage)
	add_theme_font_size_override("font_size", 24)
	global_position = target_node.global_position + Vector2(0, -20)

func _create_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y - 50, 1)
	tween.finished.connect(func() -> void:
		self.queue_free())
	return tween
