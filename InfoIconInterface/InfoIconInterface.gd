@abstract
class_name InfoIconInterface extends PanelContainer

var data: Resource:
	get:
		return _get_data()
	set(value):
		_set_data(value)

func _on_mouse_exited() -> void:
	if data == null:
		return
	PopUp.close_info(data)

func _on_mouse_entered() -> void:
	if data == null:
		return
	PopUp.show_info(PopUp.get_elements_position(self), data)

@abstract func _get_data() -> Resource
@abstract func _set_data(value: Resource) -> void
