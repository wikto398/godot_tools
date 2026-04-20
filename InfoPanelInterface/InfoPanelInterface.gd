@abstract
class_name InfoPanelInterface extends PanelContainer

@export var data: Resource = null

func _on_mouse_exited() -> void:
	if data == null:
		return
	PopUp.close_info(data)

func _on_mouse_entered() -> void:
	if data == null:
		return
	PopUp.show_info(PopUp.get_elements_position(self), data)

@abstract func insert_data(_data: Resource) -> void

func _ready() -> void:
	if data:
		insert_data(data)
