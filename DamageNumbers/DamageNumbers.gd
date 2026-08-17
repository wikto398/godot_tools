class_name DamageNumbers extends Label

var amount: int
var critical_hit: bool = false
var is_heal: bool = false
var target_node: Node2D

func _init(_amount: int, _target_node: Node2D, _critical_hit: bool = false, _is_heal: bool = false) -> void:
	amount = _amount
	critical_hit = _critical_hit
	is_heal = _is_heal
	target_node = _target_node

func _ready() -> void:
	self.text = str(amount)
	show_number()

func show_number() -> void:
	_modify_parameters()
	_create_tween()

func _modify_parameters() -> void:
	text = ("+%d" % amount) if is_heal else str(amount)
	add_theme_font_size_override("font_size", 34 if critical_hit else 24)
	if is_heal:
		add_theme_color_override("font_color", Color(0.35, 0.9, 0.35))
	elif critical_hit:
		add_theme_color_override("font_color", Color(1.0, 0.55, 0.1))
	global_position = target_node.global_position + Vector2(0, -20)

func _create_tween() -> Tween:
	var tween = create_tween()
	tween.tween_property(self, "position:y", self.position.y - 50, 1)
	tween.finished.connect(func() -> void:
		self.queue_free())
	return tween
