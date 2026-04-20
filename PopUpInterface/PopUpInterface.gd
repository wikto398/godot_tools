@abstract
class_name PopUpInterface extends Control

@onready var ui = $UI
@onready var timer: Timer = $Timer

var popups = {}
var popups_locked = false

func show_info(element_position, data: Resource):
	if popups_locked:
		return

	var popup_scene = null
	var popup_type = null
	popup_type = _get_popup_type(data)
	popup_scene = _get_popup_scene(data)

	if popup_scene:
		var popup = create_info_popup(popup_scene)
		popup.insert_data(data)
		var popup_position = _get_popup_position(popup, element_position)
		popup.position = popup_position.position
		if popups.get(popup_type):
			popups[popup_type].queue_free()
			popups.erase(popup_type)
		popups[popup_type] = popup

func close_info(data):
	var popup_type = _get_popup_type(data)
	if popup_type in popups:
		popups[popup_type].close()

func remove_info(data):
	var popup_type = _get_popup_type(data)
	if popup_type in popups:
		popups[popup_type].queue_free()
		popups.erase(popup_type)

func create_info_popup(popup_scene: PackedScene):
	var popup = popup_scene.instantiate()
	ui.add_child(popup)
	return popup

func get_elements_position(element):
	return Rect2i(element.global_position, element.size)

func _get_popup_position(popup, element_position):
	var popup_size = popup.get_size()
	var correction = Vector2i(0, 0)

	# Calculate the horizontal offset to center the popup
	correction.x = element_position.position.x + (element_position.size.x - popup_size.x) / 2

	# Check if the popup goes out of bounds on the X-axis (left or right)
	var viewport_width = get_viewport().size.x
	if correction.x < 0:
		# If the popup goes too far left, align it to the left edge of the viewport
		correction.x = 0
	elif correction.x + popup_size.x > viewport_width:
		# If the popup goes too far right, align it to the right edge of the viewport
		correction.x = viewport_width - popup_size.x

	# Determine if the popup should appear above or below the element
	var vertical_offset = 10
	if element_position.position.y <= get_viewport().size.y / 2:
		# Position popup below the element
		correction.y = element_position.position.y + element_position.size.y + vertical_offset
	else:
		# Position popup above the element
		correction.y = element_position.position.y - popup_size.y - vertical_offset

	return Rect2i(correction, popup_size)

@abstract func _get_popup_type(data: Resource)
@abstract func _get_popup_scene(popup_type)

func show_error(message: String):
	%ErrorMessage.text = message
	%ErrorPopUp.visible = true
	get_tree().create_tween().tween_property(%ErrorPopUp, "visible", false, 3)
